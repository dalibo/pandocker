#!/bin/sh -eux
# Target shell is busybox sh.

# use `test.sh stable` to test the stable version
TAG=${1:-latest}

docker create --name pandoc-volumes dalibo/pandocker:$TAG
trap 'docker rm --force --volumes pandoc-volumes' EXIT INT TERM
#docker cp tests pandoc-volumes:/pandoc/

SRC=sample-presentation.md

# the `--user` option breaks eisvogel
#DOCKER_OPT="--rm --volume=`pwd`:/pandoc --user $(id -u):$(id -g)"

# CircleCi does not mount volumes like that
#DOCKER_OPT="--rm --volume=`pwd`:/pandoc"

DOCKER_OPT="--rm --volumes-from pandoc-volumes"

PANDOC="docker run $DOCKER_OPT dalibo/pandocker:$TAG --verbose"

IN=tests/input
EXPECTED=tests/expected
OUT=tests/output

ls $IN
ls $EXPECTED

rm -fr $OUT
mkdir -p $OUT

docker cp tests pandoc-volumes:/pandoc/

##
## B U I L D
##

# 01. Beamer export
DEST=sample-presentation.beamer.pdf
$PANDOC -t beamer $IN/$SRC -o $OUT/$DEST

#docker cp pandoc-volumes:/pandoc/$DEST .

# 02. Reveal export
DEST=tmp-slides.html
$PANDOC -t revealjs $IN/$SRC -o $OUT/$DEST
#docker cp pandoc-volumes:/pandoc/$DEST .

# 03. Handout PDF export
DEST=tmp-handout.pdf
$PANDOC --pdf-engine=xelatex $IN/$SRC -o $OUT/$DEST
#docker cp pandoc-volumes:/pandoc/$DEST .

# 04. Check bug #18
# https://github.com/dalibo/pandocker/issues/18
DEST=tmp-slides.self-contained.html
$PANDOC -t revealjs $IN/$SRC --standalone --self-contained -V revealjs-url:https://revealjs.com/  -o $OUT/$DEST
#docker cp pandoc-volumes:/pandoc/$DEST .

# 05. Check bug #36 : wrapper introduces quote errors
# https://github.com/dalibo/pandocker/issues/18
PANDOCSH="docker run $DOCKER_OPT --entrypoint=pandoc1.sh dalibo/pandocker:$TAG --verbose"
DEST=tmp-handout.bug36.pdf
$PANDOCSH --latex-engine=xelatex --no-tex-ligatures $IN/$SRC -o $OUT/$DEST
#docker cp pandoc-volumes:/pandoc/$DEST .

# 06. FILTER : Minted : TEX Export
MINTED_OPT="--filter pandoc-minted --pdf-engine-opt=-shell-escape"
DEST=tmp-minted.tex
$PANDOC $MINTED_OPT $IN/minted.md  -o $OUT/$DEST
#docker cp pandoc-volumes:/pandoc/$DEST .

# 07. FILTER : Minted : PDF Export
DEST=tmp-minted.pdf
$PANDOC $MINTED_OPT --pdf-engine=xelatex  $IN/minted.md  -o $OUT/$DEST
#docker cp pandoc-volumes:/pandoc/$DEST .

# 08. Bug #44 : Support for German characters
DEST=markdown_de.pdf
$PANDOC --pdf-engine=xelatex  --template=$IN/template_de.tex $IN/markdown_de.md -o $OUT/$DEST

# 09. Template : eisvogel
DEST=eisvogel.pdf
$PANDOC --pdf-engine=xelatex  --template=eisvogel $IN/$SRC -o $OUT/$DEST

# 10. emojis
DEST=emojis.pdf
$PANDOC --pdf-engine=xelatex $IN/emojis.md -o $OUT/$DEST

# 11. Issue #75 : https://github.com/dalibo/pandocker/issues/75
$PANDOC --pdf-engine=xelatex $IN/magicienletter.md -o $OUT/magicienletter.html

##
## C H E C K
##

# fetch artefacts
docker cp pandoc-volumes:/pandoc/$OUT tests 

# 11.  Issue #75 : https://github.com/dalibo/pandocker/issues/75
diff $OUT/magicienletter.html $EXPECTED/magicienletter.html
