#!/bin/sh

RELATIVE_INPUT_DIR=$1
RELATIVE_OUTPUT_DIR=$2

puml-gen -dir /code/$RELATIVE_INPUT_DIR /code/$RELATIVE_OUTPUT_DIR
java -jar plantuml.jar /code/$RELATIVE_OUTPUT_DIR
