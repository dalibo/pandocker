#!/bin/bash -eux
#
# Backward compatibility with Pandoc 1.x command lines
#

PANDOC_ARGS=("$@")
# 1. --latex-engine becomes --pdf-engine
PANDOC_ARGS=("${PANDOC_ARGS[@]//--latex-engine/--pdf-engine}")
# 2. --no-tex-ligatures becomes --from markdown-smart
PANDOC_ARGS=("${PANDOC_ARGS[@]//--no-tex-ligatures/--from markdown-smart}")

set -x
exec pandoc "${PANDOC_ARGS[@]}"
