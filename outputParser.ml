open Lexing
open Parser
open Espressioni

let rec elabora lexbuf =
  let result = Parser.main Lexer.token lexbuf in
  match result with
  | None -> ()
  | Some blocco ->
      print_string "inizio blocco\n";
      stampablocco blocco;
      flush stdout;
      print_string "fine blocco\n";
      elabora lexbuf

let _ =
  let filer = open_in Sys.argv.(1) in
  let lexbuf = Lexing.from_channel filer in
  elabora lexbuf;
  close_in filer;
  exit 0
