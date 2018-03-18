#!/bin/sh -eux
# Target shell is busybox sh.

rm -vf tmp-*

docker create --name pandoc-volumes dalibo/pandocker:latest
trap 'docker rm --force --volumes pandoc-volumes' EXIT INT TERM
docker cp fixtures/* pandoc-volumes:/pandoc/

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
DEST=tmp-minted.tex
$PANDOC --filter pandoc-minted minted.md  -o $DEST
docker cp pandoc-volumes:/pandoc/$DEST .

# FILTER : Minted : PDF Export
DEST=tmp-minted.pdf
$PANDOC --filter pandoc-minted --pdf-engine=xelatex  minted.md  -o $DEST
docker cp pandoc-volumes:/pandoc/$DEST .