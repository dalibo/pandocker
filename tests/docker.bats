#!/usr/bin/env bats

##
## Testing the various output formats
##

log() {
  local -r log="$BATS_TEST_DIRNAME/${BATS_TEST_FILENAME##*/}.log"
  echo "$@" >> "$log"
}

run_only_test() {
  if [ "$BATS_TEST_NUMBER" -ne "$1" ]; then
    skip
  fi
  initial_setup
}

initial_setup(){
  log "initial setup"
  # clean remaining output files from previous tests
  rm -fr $OUT
  mkdir -p $OUT
  # mount a dedicated volume and put the tests files in it
  docker create --name pandoc-volumes dalibo/pandocker:$TAG
  docker cp tests pandoc-volumes:/pandoc/
}

setup() {
  # use `bats docker.bats stable` to test the stable version
  export TAG=${TAG:-latest}
  log "setup: TAG = $TAG"
  export DOCKER_OPT="--rm --volumes-from pandoc-volumes"
  export PANDOC="docker run $DOCKER_OPT dalibo/pandocker:$TAG --verbose"
  export IN=tests/input
  export EXPECTED=tests/expected
  export OUT=tests/output
  if [ "${BATS_TEST_NUMBER}" = 1 ];then
    initial_setup
  fi

  # Uncomment to launch only one test
  #run_only_test 16
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

@test "Binary docker is on the current PATH" {
  command -v docker
}

##
## Output formats
##

@test "Generate a beamer presentation" {
  $PANDOC -t beamer $IN/sample-presentation.md -o $OUT/sample-presentation.beamer.pdf
  echo "status = $status"
}

@test "Generate a reveal presentation" {
  $PANDOC -t revealjs $IN/sample-presentation.md -o $OUT/sample-presentation.reveal.html
}

@test "Generate a presentation handout" {
  $PANDOC --pdf-engine=xelatex $IN/sample-presentation.md -o $OUT/sample-presentation.handout.pdf
}

# Check bug #18 : https://github.com/dalibo/pandocker/issues/18
@test "Generate a self-contained reveal presentation" {
  $PANDOC -t revealjs $IN/sample-presentation.md --standalone --self-contained -V revealjs-url:https://revealjs.com/  -o $OUT/sample-presentation.reveal.standalone.html
}

##
## Templates
##

@test "Generate a PDF file using the eisvogel template" {
  $PANDOC --pdf-engine=xelatex  --template=eisvogel $IN/sample-presentation.md  -o $OUT/sample-presentation.eisvogel.pdf
}

@test "Generate a PDF file using the letter template" {
  $PANDOC --pdf-engine=xelatex  --template=letter $IN/letter/letter.md -o $OUT/letter.pdf
}

##
## Special Characters
##

@test "Generate a PDF file containing German characters" {
  $PANDOC --pdf-engine=xelatex \
          --template=$IN/template_de.tex \
          $IN/markdown_de.md \
          -o $OUT/markdown_de.pdf
}

@test "Generate a PDF file using the xelaxemoji minimal example" {
  xelatex $IN/xelatexemoji.tex && mv xelatexemoji.* $OUT
}

@test "Generate a PDF file containing emojis" {
  $PANDOC --pdf-engine=xelatex $IN/emojis.md -o $OUT/emojis.pdf
}

# Bug #75 : https://github.com/dalibo/pandocker/issues/75
@test "Generate a PDF file containing weird emojis" {
  $PANDOC --pdf-engine=xelatex $IN/magicienletter.md > $OUT/magicienletter.html
  diff $OUT/magicienletter.html $EXPECTED/magicienletter.html
}

##
## Input formats (other than markdown)
##

@test "Generate a markdown file from a dokuwiki source" {
  $PANDOC --from dokuwiki --to markdown $IN/syntax.dokuwiki.txt -o $OUT/syntax.dokuwiki.md
}

##
## Filters
##

@test "Generate a TEX file using the minted filter" {
  MINTED_OPT="--filter pandoc-minted --pdf-engine-opt=-shell-escape"
  $PANDOC $MINTED_OPT $IN/minted.md  -o $OUT/minted.tex
}

@test "Generate a PDF file using the minted filter" {
  MINTED_OPT="--filter pandoc-minted --pdf-engine-opt=-shell-escape"
  $PANDOC $MINTED_OPT $IN/minted.md --pdf-engine=xelatex -o $OUT/minted.tex
}

@test "Generate a markdown file using the include filter" {
  $PANDOC --to markdown --filter pandoc-include $IN/include.md > $OUT/include.complete.md
  grep -v '!include' $OUT/include.complete.md
}

@test "Generate a markdown file using the codeblock-include filter" {
  $PANDOC --filter pandoc-codeblock-include $IN/codeblock_include.md -o $OUT/codeblock_include.complete.md
}

@test "Generate a PDF file using the citeproc filter" {
  $PANDOC --filter pandoc-citeproc --bibliography=$IN/citeproc.bibtex -M link-citations $IN/citeproc.md -o $OUT/citeproc.pdf
}

@test "Generate a markdown file using the crossref filter" {
  $PANDOC --to markdown --filter pandoc-crossref $IN/crossref.md > $OUT/crossref.md
  diff $OUT/crossref.md $EXPECTED/crossref.md
}


##
## Fonts
##

@test "Generate a PDF file with the Deja Vu font" {
  $PANDOC --pdf-engine=xelatex $IN/fonts.md -o $OUT/fonts_dejavu.pdf --variable mainfont="DejaVu Sans"
}

@test "Generate a PDF file with the Lato font" {
  $PANDOC --pdf-engine=xelatex $IN/fonts.md -o $OUT/fonts_lato.pdf --variable mainfont="Lato"
}

@test "Generate a PDF file with the Liberation font" {
  $PANDOC --pdf-engine=xelatex $IN/fonts.md -o $OUT/fonts_lato.pdf --variable mainfont="Liberation Serif"
}

@test "Generate a PDF file with the Noto font" {
  $PANDOC --pdf-engine=xelatex $IN/fonts.md -o $OUT/fonts_noto.pdf --variable mainfont="Noto Sans"
}

@test "Generate a PDF file with the Noto Emoji font" {
  $PANDOC --pdf-engine=xelatex $IN/fonts.md -o $OUT/fonts_noto_emoji.pdf --variable mainfont="Noto Emoji Color"
}

##
## Other tools
##

@test "Generate a SVG image with dia" {
    DIA="docker run $DOCKER_OPT --entrypoint dia dalibo/pandocker:$TAG --verbose"
    $DIA $IN/db.dia --export $OUT/db.svg
}


##
## Misc.
##

# Check bug #36 : https://github.com/dalibo/pandocker/issues/18
@test "Generate a PDF file with the pandoc 1.x wrapper" {
  PANDOCSH="docker run $DOCKER_OPT --entrypoint=pandoc1.sh dalibo/pandocker:$TAG --verbose"
  $PANDOCSH --latex-engine=xelatex --no-tex-ligatures $IN/sample-presentation.md -o $OUT/sample-presentation.handout.bug36.pdf
}

@test "Generate a PDF file using the inline mode" {
    PANDOC_PDF_BOX=docker run --rm -i dalibo/pandocker:$TAG --to=pdf --pdf-engine=xelatex
    cat $IN/markdown_de.md | $PANDOC_PDF_BOX > $OUT/markdown_de.inline.pdf
}
