open Lexing
open Parser
open Espressioni

let rec elaboraRisposte lexbuf =
  let result = Parser.main Lexer.token lexbuf in
  match result with
  | None -> ()
  | Some blocco ->
      Espressioni.stampaLista (Espressioni.valuta blocco);
      flush stdout;
      elaboraRisposte lexbuf

let _ =
  let filer = open_in Sys.argv.(1) in
  let lexbuf = Lexing.from_channel filer in
  elaboraRisposte lexbuf;
  close_in filer;
  exit 0
