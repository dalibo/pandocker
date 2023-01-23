#!/usr/bin/env bats

## Example: TAG=stable TEXT_ONLY=413 bats extra.bats

##
## Useful fonctions
##

log() {
  local -r log="$BATS_TEST_DIRNAME/${BATS_TEST_FILENAME##*/}.log"
  echo "$@" >> "$log"
}

initial_setup(){
  #log "initial setup"
  # remove artefacts from previous tests,
  # but keep the directory structure
  find $OUT -type f -and -not -name .keep -delete
  # allow all users to write artefacts
  chmod a+rwx $OUT
  # mount a dedicated volume and put the tests files in it
  [[ "$PANDOC" =~ "docker" ]] && docker create --name pandoc-volumes dalibo/pandocker:$TAG
  [[ "$PANDOC" =~ "docker" ]] && docker cp tests pandoc-volumes:/pandoc/
}

setup() {
  export TAG=${TAG:-latest}
  export VARIANT=${VARIANT:-}
  log "setup: TAG = $TAG & VARIANT=$VARIANT"
  export DOCKER_OPT="--rm --volumes-from pandoc-volumes "
  export PANDOC="${PANDOC:-docker run $DOCKER_OPT dalibo/pandocker:$TAG --verbose}"
  export DIFF="${DIFF:-docker run $DOCKER_OPT --entrypoint=diff dalibo/pandocker:$TAG}"
  export IN=tests/input
  export EXP=tests/expected
  export OUT=tests/output
  if [ "${BATS_TEST_NUMBER}" = 1 ];then
    initial_setup
  fi
}

final_teardown() {
  # fetch artefacts
  [[ "$PANDOC" =~ "docker" ]] && docker cp pandoc-volumes:/pandoc/$OUT tests
  # destroy the volume
  [[ "$PANDOC" =~ "docker" ]] && docker rm --force --volumes pandoc-volumes
}

teardown() {
  if [ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]; then
    final_teardown
  fi
}

##
## 0xx: Misc
##

@test "011: Binary docker is on the current PATH" {
  [[ "$PANDOC" =~ "docker" ]] && command -v docker
}

@test "031: a PDF file using the inline mode" {
  [[ "$PANDOC" == "pandoc" ]] && skip
  PANDOC_PDF_BOX=docker run --rm -i dalibo/pandocker:$TAG --to=pdf --pdf-engine=xelatex
  cat $IN/markdown_de.md | $PANDOC_PDF_BOX > $OUT/markdown_de.inline.pdf
}

##
## 1xx: Output formats
##

@test "101: A beamer presentation" {
  $PANDOC -t beamer $IN/sample-presentation.md -o $OUT/sample-presentation.beamer.pdf
}

@test "111: A reveal presentation" {
  $PANDOC -t revealjs $IN/sample-presentation.md \
          --standalone \
          -V revealjs-url:https://unpkg.com/reveal.js@4/ \
          -o $OUT/sample-presentation.reveal.html
}

# Check bug #18 : https://github.com/dalibo/pandocker/issues/18
@test "112: A self-contained reveal presentation built offline" {
  $PANDOC -t revealjs $IN/sample-presentation.md \
          --standalone \
          --self-contained \
          -V theme:beige \
          -o $OUT/sample-presentation.reveal.selfcontained.html
}

@test "121: A presentation handout" {
  $PANDOC --pdf-engine=xelatex $IN/sample-presentation.md -o $OUT/sample-presentation.handout.pdf
}

###
### 2xx: Input formats (other than markdown)
###

## 21x: dokuwiki
@test "211: Generate a markdown file from a dokuwiki source" {
  DIR=dokuwiki
  $PANDOC --from dokuwiki --to markdown \
          $IN/$DIR/syntax.dokuwiki.txt \
          -o $OUT/$DIR/syntax.dokuwiki.md
  $DIFF $OUT/$DIR/syntax.dokuwiki.md $EXP/$DIR/syntax.dokuwiki.md
}

##
## 3xx: Templates
##

## 31x: Eisvogel
@test "311: A PDF file using the eisvogel template with pdftex" {
  $PANDOC --template=eisvogel $IN/sample-presentation.md  -o $OUT/sample-presentation.eisvogel.pdftex.pdf
}

@test "312: A PDF file using the eisvogel template with xelatex" {
  DOCKER_OPT="--rm --volumes-from pandoc-volumes -u 1000:1000"
  PANDOC="docker run $DOCKER_OPT dalibo/pandocker:$TAG --verbose"
  $PANDOC --pdf-engine=xelatex --template=eisvogel \
          $IN/sample-presentation.md  \
          -o $OUT/sample-presentation.eisvogel.xelatex.pdf
}

## 32x: Letter
## https://github.com/dalibo/pandocker/issues/178
@test "321: Generate a PDF file using the letter template" {
  skip "letter template is deprecated"
  $PANDOC --pdf-engine=xelatex  --template=letter $IN/letter/letter.md -o $OUT/letter.pdf
}


## 33x: Leaflet
@test "331: Generate a PDF brochure using the leaflet template" {
  skip "leaflet template is deprecated"
  $PANDOC --pdf-engine=xelatex  --template=leaflet $IN/leaflet/leaflet.md -o $OUT/leaflet.pdf
}

##
## 4xx: Fonts, Langages and Special Characters
##

## 41x: Languages

@test "411: Generate a PDF file containing German characters" {
  DIR=german
  $PANDOC --pdf-engine=xelatex \
          --template=$IN/$DIR/template_de.tex \
          $IN/$DIR/markdown_de.md \
          -o $OUT/$DIR/markdown_de.pdf
}

@test "412: Generate a PDF file containing Dutch characters" {
  DIR=dutch
  $PANDOC --pdf-engine=xelatex \
          --template=$IN/$DIR/template_nl.tex \
          $IN/$DIR/markdown_nl.md \
          -o $OUT/$DIR/markdown_nl.pdf
}

@test "413: a PDF file containing Spanish characters" {
  DIR=spanish
  $PANDOC --pdf-engine=xelatex \
          $IN/$DIR/markdown_es.md \
          -o $OUT/$DIR/markdown_es.pdf
}

## 42x: Fonts
@test "421: Generate a PDF file with the Deja Vu font" {
  DIR=fonts
  $PANDOC --pdf-engine=xelatex $IN/$DIR/fonts.md \
          -o $OUT/$DIR/fonts_dejavu.pdf \
          --variable mainfont="DejaVu Sans"
}

@test "422: Generate a PDF file with the Lato font" {
  DIR=fonts
  $PANDOC --pdf-engine=xelatex $IN/$DIR/fonts.md \
          -o $OUT/$DIR/fonts_lato.pdf \
          --variable mainfont="Lato"
}

@test "423: Generate a PDF file with the Liberation font" {
  DIR=fonts
  $PANDOC --pdf-engine=xelatex $IN/$DIR/fonts.md \
          -o $OUT/$DIR/fonts_lato.pdf \
          --variable mainfont="Liberation Serif"
}


## 45x: FontAwesome
@test "451: A PDF file containing awesomeboxes with fontawesome" {
  DIR=fonts
  $PANDOC $IN/$DIR/boxes.md \
          --template=eisvogel \
          --pdf-engine=xelatex \
          --filter pandoc-latex-environment \
          --listings \
          -o $OUT/$DIR/boxes.pdf
}

@test "452: A PDF file containing fontawesome macros" {
  DIR=fonts
  $PANDOC $IN/$DIR/fontawesome.md \
          --pdf-engine=xelatex \
          -o $OUT/$DIR/fontawesome.pdf
}

## 46x: SVG
@test "461: A PDF with an SVG image" {
  DIR=svg
  $PANDOC $IN/$DIR/svg.md --pdf-engine=xelatex -o $OUT/$DIR/svg.pdf
}

##
## 5xx: Filters
##

## 51x: pandoc-minted
@test "511: Generate a TEX file using the minted filter" {
  skip "minted is deprecated"
  DIR=pandoc-minted
  $PANDOC $IN/$DIR/minted.md  \
          --filter pandoc-minted \
          -o $OUT/$DIR/minted.tex
}

@test "512: Generate a PDF file using the minted filter" {
  skip "minted is deprecated"
  DIR=pandoc-minted
  $PANDOC $IN/$DIR/minted.md  \
          --filter pandoc-minted \
          --pdf-engine=xelatex \
          --pdf-engine-opt=-shell-escape \
          -o $OUT/$DIR/minted.pdf
}

## 52x: pandoc-include + pandoc-codeblock-include
@test "521: Generate a markdown file using the include filter" {
  DIR=pandoc-include
  $PANDOC --to markdown --filter pandoc-include \
          $IN/$DIR/include.md \
          -o $OUT/$DIR/include.complete.md
  $DIFF $OUT/$DIR/include.complete.md $EXP/$DIR/include.complete.md
}

@test "522: Generate a markdown file using the codeblock-include filter" {
  skip "codeblock-include filter is disabled"
  DIR=pandoc-codeblock-include
  $PANDOC --to markdown \
          --filter pandoc-codeblock-include \
          $IN/$DIR/codeblock_include.md \
          -o $OUT/$DIR/codeblock_include.complete.md
  $DIFF $OUT/$DIR/codeblock_include.complete.md $EXP/$DIR/codeblock_include.complete.md
}

## 53x: pandoc-citeproc + pandoc-crossref
## pandoc-citeproc is deprecated, we test --citeproc instead
@test "531: A PDF file using the citeproc filter" {
  DIR=pandoc-citeproc
  $PANDOC $IN/$DIR/citeproc.md \
          --citeproc \
          --bibliography=$IN/$DIR/citeproc.bibtex \
          -M link-citations \
          -o $OUT/$DIR/citeproc.pdf
}

@test "532: A markdown file using the crossref filter" {
  DIR=pandoc-crossref
  $PANDOC --filter pandoc-crossref \
          $IN/$DIR/crossref.md \
          -o $OUT/$DIR/crossref.md
  $DIFF $OUT/$DIR/crossref.md $EXP/$DIR/crossref.md
}

# Check if there's a version mismatch between crossref and pandoc
# https://github.com/dalibo/pandocker/issues/207
@test "533: pandoc-crossref version is correct" {
  DIR=pandoc-crossref
  run $PANDOC $IN/$DIR/empty.md \
              --filter pandoc-crossref \
              --to markdown \
              --output /dev/null
  echo ${output} | grep -v 'WARNING:'
}

## 54x: pandoc-mustache
@test "541: Generate a markdown file using the mustache filter" {
  DIR=pandoc-mustache
  $PANDOC $IN/$DIR/weather.md \
          --filter pandoc-mustache \
          -o $OUT/$DIR/weather.md
  $DIFF $OUT/$DIR/weather.md  $EXP/$DIR/weather.md
}

## 55x: pandoc-latex-admonition
@test "551: A PDF file using the admonition filter" {
  DIR=pandoc-latex-admonition
  $PANDOC $IN/$DIR/admonition.md \
          --filter pandoc-latex-admonition \
          --output $OUT/$DIR/admonition.pdf
}

## 56x: pandoc-latex-color and pandoc-latex-fontsize
@test "561: A PDF file with custom color and fontsize" {
  DIR=pandoc-latex-color
  $PANDOC $IN/$DIR/colors_and_fontsize.md \
          --filter pandoc-latex-color \
          --filter pandoc-latex-fontsize \
          --filter pandoc-latex-newpage \
          --output $OUT/$DIR/colors_and_fontsize.pdf
}


## 57x: pandoc-cover
@test "571: A PDF file with a custom SVG cover" {
  DIR=pandoc-cover
  $PANDOC $IN/$DIR/sample.md \
          --template=eisvogel \
          --filter pandoc-cover \
          --output $OUT/$DIR/sample.pdf
}

##
## 9xx: Other entrypoints
##

