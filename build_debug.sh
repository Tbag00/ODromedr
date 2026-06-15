#!/bin/bash
set -e

ocamlc -c outputLexer.ml
ocamlc -o outputLexer espressioni.cmo Lexer.cmo parser.cmo outputLexer.cmo

ocamlc -c outputParser.ml
ocamlc -o outputParser espressioni.cmo Lexer.cmo parser.cmo outputParser.cmo

ocamlc -c outputParserInfissa.ml
ocamlc -o outputParserInfissa espressioni.cmo Lexer.cmo parser.cmo outputParserInfissa.cmo

echo "Build debug completata: outputLexer, outputParser, outputParserInfissa"
