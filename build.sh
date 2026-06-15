#!/bin/bash
set -e   # interrompe lo script al primo errore

ocamlc -c espressioni.ml
ocamlyacc parser.mly
ocamlc -c parser.mli
ocamllex Lexer.mll
ocamlc -c Lexer.ml
ocamlc -c parser.ml
ocamlc -c main.ml
ocamlc -o ODromedr espressioni.cmo Lexer.cmo parser.cmo main.cmo

echo "Build completata: ODromedr"
