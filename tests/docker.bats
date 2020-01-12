#!/usr/bin/env bats

##
## Useful fonctions
##

log() {
  local -r log="$BATS_TEST_DIRNAME/${BATS_TEST_FILENAME##*/}.log"
  echo "$@" >> "$log"
}

initial_setup(){
  log "initial setup"
  # clean remaining output files from previous tests
  rm -fr $OUT
  mkdir -p $OUT
  chmod a+rwx $OUT
  # mount a dedicated volume and put the tests files in it
  docker create --name pandoc-volumes dalibo/pandocker:$TAG
  docker cp tests pandoc-volumes:/pandoc/
}

setup() {
  # use `TAG=stable bats docker.bats` to test the stable version
  export TAG=${TAG:-latest}
  log "setup: TAG = $TAG"
  export DOCKER_OPT="--rm --volumes-from pandoc-volumes "
  export PANDOC="docker run $DOCKER_OPT dalibo/pandocker:$TAG --verbose"
  export IN=tests/input
  export EXP=tests/expected
  export OUT=tests/output
  if [ "${BATS_TEST_NUMBER}" = 1 ];then
    initial_setup
  fi
}

final_teardown() {
  # fetch artefacts
  docker cp pandoc-volumes:/pandoc/$OUT tests
  # destroy the volume
  docker rm --force --volumes pandoc-volumes
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
  command -v docker
}

# Check bug #36 : https://github.com/dalibo/pandocker/issues/18
@test "021: Generate a PDF file with the pandoc 1.x wrapper" {
  PANDOCSH="docker run $DOCKER_OPT --entrypoint=pandoc1.sh dalibo/pandocker:$TAG --verbose"
  $PANDOCSH --latex-engine=xelatex --no-tex-ligatures $IN/sample-presentation.md -o $OUT/sample-presentation.handout.bug36.pdf
}

@test "031: Generate a PDF file using the inline mode" {
    PANDOC_PDF_BOX=docker run --rm -i dalibo/pandocker:$TAG --to=pdf --pdf-engine=xelatex
    cat $IN/markdown_de.md | $PANDOC_PDF_BOX > $OUT/markdown_de.inline.pdf
}

##
## 1xx: Output formats
##

@test "101: Generate a beamer presentation" {
  $PANDOC -t beamer $IN/sample-presentation.md -o $OUT/sample-presentation.beamer.pdf
  echo "status = $status"
}

@test "111: Generate a reveal presentation" {
  $PANDOC -t revealjs $IN/sample-presentation.md -o $OUT/sample-presentation.reveal.html
}

# Check bug #18 : https://github.com/dalibo/pandocker/issues/18
@test "112: Generate a self-contained reveal presentation" {
  $PANDOC -t revealjs $IN/sample-presentation.md \
          --standalone --self-contained \
          -V revealjs-url:https://revealjs.com/ \
          -o $OUT/sample-presentation.reveal.standalone.html
}

@test "121: Generate a presentation handout" {
  $PANDOC --pdf-engine=xelatex $IN/sample-presentation.md -o $OUT/sample-presentation.handout.pdf
}

###
### 2xx: Input formats (other than markdown)
###

## 21x: dokuwiki
@test "211: Generate a markdown file from a dokuwiki source" {
  $PANDOC --from dokuwiki --to markdown $IN/syntax.dokuwiki.txt \
          -o $OUT/syntax.dokuwiki.md
}

##
## 3xx: Templates
##

## 31x: Eisvogel
@test "311: Generate a PDF file using the eisvogel template with pdftex" {
  $PANDOC --template=eisvogel $IN/sample-presentation.md  -o $OUT/sample-presentation.eisvogel.pdftex.pdf
}

@test "312: Generate a PDF file using the eisvogel template with xelatex" {
  DOCKER_OPT="--rm --volumes-from pandoc-volumes -u 1000:1000"
  PANDOC="docker run $DOCKER_OPT dalibo/pandocker:$TAG --verbose"
  $PANDOC --pdf-engine=xelatex --template=eisvogel $IN/sample-presentation.md  -o $OUT/sample-presentation.eisvogel.xelatex.pdf
}

## 32x: Letter
@test "321: Generate a PDF file using the letter template" {
  $PANDOC --pdf-engine=xelatex  --template=letter $IN/letter/letter.md -o $OUT/letter.pdf
}

## 33x: Leaflet
@test "331: Generate a PDF brochure using the leaflet template" {
  $PANDOC --pdf-engine=xelatex  --template=leaflet $IN/leaflet/leaflet.md -o $OUT/leaflet.pdf
}

##
## 4xx: Fonts, Langages and Special Characters
##

## 41x: Languages

@test "411: Generate a PDF file containing German characters" {
  $PANDOC --pdf-engine=xelatex \
          --template=$IN/template_de.tex \
          $IN/markdown_de.md \
          -o $OUT/markdown_de.pdf
}

@test "412: Generate a PDF file containing Dutch characters" {
  $PANDOC --pdf-engine=xelatex \
          --template=$IN/template_nl.tex \
          $IN/markdown_nl.md \
          -o $OUT/markdown_nl.pdf
}

## 42x: Fonts
@test "421: Generate a PDF file with the Deja Vu font" {
  $PANDOC --pdf-engine=xelatex $IN/fonts.md \
          -o $OUT/fonts_dejavu.pdf \
          --variable mainfont="DejaVu Sans"
}

@test "422: Generate a PDF file with the Lato font" {
  $PANDOC --pdf-engine=xelatex $IN/fonts.md \
          -o $OUT/fonts_lato.pdf \
          --variable mainfont="Lato"
}

@test "423: Generate a PDF file with the Liberation font" {
  $PANDOC --pdf-engine=xelatex $IN/fonts.md \
          -o $OUT/fonts_lato.pdf \
          --variable mainfont="Liberation Serif"
}

@test "424: Generate a PDF file with the Noto font" {
  $PANDOC --pdf-engine=xelatex $IN/fonts.md \
          -o $OUT/fonts_noto.pdf \
          --variable mainfont="Noto Sans"
}

## 44x: Emojis
@test "441: Generate a PDF file containing emojis" {
  $PANDOC --pdf-engine=xelatex $IN/emojis.md -o $OUT/emojis.pdf
}

# Bug #75 : https://github.com/dalibo/pandocker/issues/75
@test "442: Generate a PDF file containing weird emojis" {
  $PANDOC --pdf-engine=xelatex $IN/magicienletter.md > $OUT/magicienletter.html
  diff $OUT/magicienletter.html $EXP/magicienletter.html
}


##
## 5xx: Filters
##

## 51x: pandoc-minted
@test "511: Generate a TEX file using the minted filter" {
  MINTED_OPT="--filter pandoc-minted --pdf-engine-opt=-shell-escape"
  $PANDOC $MINTED_OPT $IN/minted.md  -o $OUT/minted.tex
}

@test "512: Generate a PDF file using the minted filter" {
  MINTED_OPT="--filter pandoc-minted --pdf-engine-opt=-shell-escape"
  $PANDOC $MINTED_OPT $IN/minted.md --pdf-engine=xelatex -o $OUT/minted.tex
}

## 52x: pandoc-include + pandoc-codeblock-include
@test "521: Generate a markdown file using the include filter" {
  $PANDOC --to markdown --filter pandoc-include $IN/include.md > $OUT/include.complete.md
  grep -v '!include' $OUT/include.complete.md
}

@test "522: Generate a markdown file using the codeblock-include filter" {
  $PANDOC --filter pandoc-codeblock-include $IN/codeblock_include.md -o $OUT/codeblock_include.complete.md
}

## 53x: pandoc-citeproc + pandoc-crossref
@test "531: Generate a PDF file using the citeproc filter" {
  $PANDOC --filter pandoc-citeproc --bibliography=$IN/citeproc.bibtex -M link-citations $IN/citeproc.md -o $OUT/citeproc.pdf
}

@test "532: Generate a markdown file using the crossref filter" {
  $PANDOC --to markdown --filter pandoc-crossref $IN/crossref.md > $OUT/crossref.md
  diff $OUT/crossref.md $EXP/crossref.md
}

## 54x: pandoc-mustache
@test "541: Generate a markdown file using the mustache filter" {
  DIR=pandoc-mustache
  mkdir -p $OUT/$DIR
  ls $OUT/$DIR
  $PANDOC $IN/$DIR/weather.md --to markdown --filter pandoc-mustache > $OUT/$DIR/weather.md
  diff $OUT/$DIR/weather.md  $EXP/$DIR/weather.md
}

##
## 9xx: Other entrypoints
##

@test "911: Generate a SVG image with dia" {
    DIA="docker run $DOCKER_OPT --entrypoint dia dalibo/pandocker:$TAG --verbose"
    $DIA $IN/db.dia --export $OUT/db.svg
}


