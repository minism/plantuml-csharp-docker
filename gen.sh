#!/bin/sh

INPUT_DIR="/code/$1"
shift
OUTPUT_DIR="/code/$1"
shift
TMP_DIR=/tmp/output

mkdir $TMP_DIR
puml-gen $INPUT_DIR $TMP_DIR -dir $@
java -jar plantuml.jar -tsvg "$TMP_DIR/**.puml"
rsync -avm --include='*.png' --include='*.svg' -f 'hide,! */' $TMP_DIR/ $OUTPUT_DIR
