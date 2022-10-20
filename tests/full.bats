#!/usr/bin/env bats

##
## Testing the full variant
##
## Example: TAG=stable TEXT_ONLY=1411 bats full.bats
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
  log "NUMBER = ${BATS_TEST_NUMBER}"
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
## 14xx: Fonts, Langages and Special Characters
##

## 141x: Languages

@test "1411: A PDF file containing Persian characters" {
  DIR=persian
  $PANDOC --pdf-engine=xelatex \
          --template eisvogel \
          --variable mainfont='Nazli' \
          $IN/$DIR/markdown_fa.md \
          -o $OUT/$DIR/markdown_fa.pdf
}

@test "1412: A PDF file containing Hindi characters" {
  DIR=persian
  $PANDOC --pdf-engine=xelatex \
          --template eisvogel \
          --variable mainfont='Lohit Devanagari' \
          $IN/$DIR/markdown_fa.md \
          -o $OUT/$DIR/markdown_fa.pdf
}

## 142x : Fonts

@test "1421: A PDF file with the Noto font" {
  DIR=fonts
  $PANDOC --pdf-engine=xelatex $IN/$DIR/fonts.md \
          -o $OUT/$DIR/fonts_noto.pdf \
          --variable mainfont="Noto Sans"
}

## 144x: Emojis
@test "1441: A PDF file containing emojis" {
  skip "Emojis are not supported at the moment"
  DIR=emojis
  $PANDOC $IN/$DIR/emojis.md \
          --pdf-engine=xelatex \
          -o $OUT/$DIR/emojis.pdf
}

# Bug #75 : https://github.com/dalibo/pandocker/issues/75
@test "1442: An HTML file containing weird emojis" {
  DIR=emojis
  $PANDOC $IN/$DIR/magicienletter.md -o $OUT/$DIR/magicienletter.html
  $DIFF $OUT/$DIR/magicienletter.html $EXP/$DIR/magicienletter.html
}



##
## 19xx: Other entrypoints
##

@test "1911: An SVG image with dia" {
    DIR=dia
    DIA="docker run $DOCKER_OPT --entrypoint dia dalibo/pandocker:$TAG --verbose"
    $DIA $IN/$DIR/db.dia --export $OUT/$DIR/db.svg
}


