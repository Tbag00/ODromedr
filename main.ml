open Lexing
open Parser
open Espressioni

let rec elaboraRisposte lexbuf =
  let result = Parser.main Lexer.token lexbuf in
  match result with
  | None -> ()
  | Some blocco ->
      (try
        Espressioni.stampaLista (Espressioni.valuta blocco);
        flush stdout;
      with
      | ErroreTipo msg ->
          Printf.printf "Errore di tipo: %s\n" msg
      | ErroreLunghezza (n, m) ->
          Printf.printf "Errore: vettori di lunghezza diversa (%d vs %d)\n" n m
      | VariabileNonDefinita v ->
          Printf.printf "Errore: variabile '%s' non definita\n" v
      );
      elaboraRisposte lexbuf
;;

let _ =
  let filer = open_in Sys.argv.(1) in
  let lexbuf = Lexing.from_channel filer in
  elaboraRisposte lexbuf;
  close_in filer;
  exit 0
