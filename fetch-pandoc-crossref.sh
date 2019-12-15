#!/bin/sh -eux

PANDOC_VERSION=$1
# pandoc-crossref's binaries ship with the pandoc version in the artifact, underscores instead of periods
CROSSREF_PANDOC_VERSION_ID="$(echo "${PANDOC_VERSION}" | tr '.' '_')"
PANDOC_CROSSREF_VERSION=$2
DEST=${3-pandoc_crossref.tar.gz}
URL=https://github.com/lierdakil/pandoc-crossref/releases/download/v${PANDOC_CROSSREF_VERSION}/linux-pandoc_${CROSSREF_PANDOC_VERSION_ID}.tar.gz

exec wget --continue --timestamping --output-document ${DEST} ${URL}
