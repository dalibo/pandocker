#!/bin/sh -eux
# Target shell is busybox sh.

rm -vf tmp-*

docker create --name pandoc-volumes dalibo/pandocker:latest
trap 'docker rm --force --volumes pandoc-volumes' EXIT INT TERM
docker cp fixtures/sample-presentation.md pandoc-volumes:/pandoc/

PANDOC="docker run --rm --volumes-from pandoc-volumes dalibo/pandocker:latest --verbose"

DEST=tmp-slides.pdf
$PANDOC -t beamer sample-presentation.md -o $DEST
docker cp pandoc-volumes:/pandoc/$DEST .

DEST=tmp-slides.html
$PANDOC -t revealjs sample-presentation.md -o $DEST
docker cp pandoc-volumes:/pandoc/$DEST .
