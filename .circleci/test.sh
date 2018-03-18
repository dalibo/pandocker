#!/bin/sh -eux
# Target shell is busybox sh.

rm -vf tmp-*

docker create --name pandoc-volumes dalibo/pandocker:latest
trap 'docker rm --force --volumes pandoc-volumes' EXIT INT TERM
docker cp fixtures/sample-presentation.md pandoc-volumes:/pandoc/

SRC=sample-presentation.md
PANDOC="docker run --rm --volumes-from pandoc-volumes dalibo/pandocker:latest --verbose"

# 01. Beamer export
DEST=tmp-slides.pdf
$PANDOC -t beamer $SRC -o $DEST
docker cp pandoc-volumes:/pandoc/$DEST .

# 02. Reveal export
DEST=tmp-slides.html
$PANDOC -t revealjs $SRC -o $DEST
docker cp pandoc-volumes:/pandoc/$DEST .

# 03. Handout PDF export
DEST=tmp-handout.pdf
$PANDOC --pdf-engine=xelatex $SRC -o $DEST
docker cp pandoc-volumes:/pandoc/$DEST .

# 04. Check bug #18
# https://github.com/dalibo/pandocker/issues/18
DEST=tmp-slides.self-contained.html
$PANDOC -t revealjs $SRC --standalone --self-contained -V revealjs-url:https://revealjs.com/  -o $DEST
docker cp pandoc-volumes:/pandoc/$DEST .

# 05. Check bug #36 : wrapper introduces quote errors
# https://github.com/dalibo/pandocker/issues/18
PANDOCSH="docker run --rm --volumes-from pandoc-volumes --entrypoint=/usr/local/bin/pandoc.sh dalibo/pandocker:latest --verbose"
DEST=tmp-handout.bug36.pdf
$PANDOCSH --latex-engine=xelatex --no-tex-ligatures $SRC -o $DEST 
docker cp pandoc-volumes:/pandoc/$DEST .
