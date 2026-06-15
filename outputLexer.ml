open Lexing
open Parser

let print_token = function
  | INT n -> print_string "INT "; print_int n; print_newline ()
  | VAR s -> print_string "VAR "; print_string s; print_newline ()
  | PLUS -> print_string "PLUS"; print_newline ()
  | MINUS -> print_string "MINUS"; print_newline ()
  | TIMES -> print_string "TIMES"; print_newline ()
  | LPAREN -> print_string "LPAREN"; print_newline ()
  | RPAREN -> print_string "RPAREN"; print_newline ()
  | INIZIOVEC -> print_string "INIZIOVEC"; print_newline ()
  | FINEVEC -> print_string "FINEVEC"; print_newline ()
  | COMMA -> print_string "COMMA"; print_newline ()
  | ASSEGNA -> print_string "ASSEGNA"; print_newline ()
  | SEMICOLON -> print_string "SEMICOLON"; print_newline ()
  | INIZIOBLOCCO -> print_string "INIZIOBLOCCO"; print_newline ()
  | FINEBLOCCO -> print_string "FINEBLOCCO"; print_newline ()
  | EOF -> print_string "EOF"; print_newline ()

let rec elabora lexbuf =
  let tok = Lexer.token lexbuf in
  print_token tok;
  match tok with
  | EOF -> ()
  | _ -> elabora lexbuf

let _ =
  let filer = open_in Sys.argv.(1) in
  let lexbuf = Lexing.from_channel filer in
  elabora lexbuf;
  close_in filer;
  exit 0
