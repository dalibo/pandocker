#!/bin/sh -eux

PANDOC_VERSION=$1
DEST=${2-pandoc.deb}
URL=https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-amd64.deb

exec wget --continue --timestamping --output-document ${DEST} ${URL}
