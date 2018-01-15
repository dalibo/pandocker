#!/bin/bash -eux

##
## Backward compatibility with Pandoc 1.x command lines
##
## 1. --latex-engine becomes --pdf-engine
## 2. --no-tex-ligatures becomes --from markdown-smart
##
exec pandoc $(sed -e's/--latex-engine/--pdf-engine/; s/--no-tex-ligatures/--from markdown-smart/' <<< $@)
