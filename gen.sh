#!/bin/sh

RELATIVE_INPUT_DIR=$1
shift
RELATIVE_OUTPUT_DIR=$1
shift

puml-gen /code/$RELATIVE_INPUT_DIR /code/$RELATIVE_OUTPUT_DIR -dir $@
java -jar plantuml.jar -tsvg "/code/$RELATIVE_OUTPUT_DIR/**.puml"
