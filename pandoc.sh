#!/bin/bash -eux
exec pandoc ${@//--latex-engine/--pdf-engine}
