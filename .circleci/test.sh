#!/bin/sh -eux
# Target shell is busybox sh.

rm -vf tmp-*

docker create --name pandoc-volumes dalibo/pandocker:latest
trap 'docker rm --force --volumes pandoc-volumes' EXIT INT TERM
docker cp fixtures/sample-presentation.md pandoc-volumes:/pandoc/
docker cp fixtures/img pandoc-volumes:/pandoc/
docker cp fixtures/minted.md pandoc-volumes:/pandoc/


PANDOC="docker run --rm --volumes-from pandoc-volumes dalibo/pandocker:latest --verbose"

DEST=tmp-slides.pdf
$PANDOC -t beamer sample-presentation.md -o $DEST
docker cp pandoc-volumes:/pandoc/$DEST .

DEST=tmp-slides.html
$PANDOC -t revealjs sample-presentation.md -o $DEST
docker cp pandoc-volumes:/pandoc/$DEST .

# Check bug #18
# https://github.com/dalibo/pandocker/issues/18
DEST=tmp-slides.self-contained.html
$PANDOC -t revealjs sample-presentation.md --standalone --self-contained -V revealjs-url:https://revealjs.com/  -o $DEST
docker cp pandoc-volumes:/pandoc/$DEST .


# FILTER : Minted : TEX Export
MINTED_OPT="--filter pandoc-minted --pdf-engine-opt=-shell-escape"
DEST=tmp-minted.tex
$PANDOC $MINTED_OPT minted.md  -o $DEST
docker cp pandoc-volumes:/pandoc/$DEST .

# FILTER : Minted : PDF Export
DEST=tmp-minted.pdf
$PANDOC $MINTED_OPT --pdf-engine=xelatex  minted.md  -o $DEST
docker cp pandoc-volumes:/pandoc/$DEST .