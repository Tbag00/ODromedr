(* Risultato della valutazione *)
type valore =
  | VInt of int
  | VVett of int list

(* Per costruzione albero sintattico *)
type espressione =
  | Int of int
  | Var of string
  | Ass of string * espressione
  | Neg of espressione
  | Sum of espressione * espressione
  | Diff of espressione * espressione
  | Mult of espressione * espressione
  | Vettore of espressione list

type blocco =
  Blocco of (espressione list)
;;

let valuta (Blocco b) = (* valuta un blocco *)
  let rec eval env = function (* valuta un'espressione *)
    | Int n -> VInt n
    | Vettore lst ->
        VVett (List.map (fun x ->
            match eval env x with (* posso mettere anche espressioni dentro un vettore *)
            | VInt n -> n (* un vettore deve contenere interi non VInt *)
            | VVett _ -> failwith "elementi del vettore devono essere interi"
          ) lst)
    | Var v -> List.assoc v env
    | Neg e -> (match eval env e with
        | VInt n -> VInt (-n)
        | VVett x -> VVett (List.map (fun n -> -n) x))
    | Sum(e1,e2) -> (match eval env e1, eval env e2 with
        | VInt n, VInt m -> VInt (n + m)
        | VVett x, VVett y ->
            if List.length x <> List.length y then
              failwith "vettori di lunghezza diversa"
            else
              VVett (List.map2 (+) x y) (* map2 prende due liste e applica + *)
        | _ -> failwith "Errore in Sum"
      )
    | Diff(e1,e2) -> (match eval env e1, eval env e2 with
        | VInt n, VInt m -> VInt (n - m)
        | VVett x, VVett y ->
            if List.length x <> List.length y then
              failwith "vettori di lunghezza diversa"
            else
              VVett (List.map2 (-) x y)
        | _ -> failwith "Errore in Diff"
      )
    | Mult(e1,e2) -> (match eval env e1, eval env e2 with
        | VInt n, VInt m -> VInt (n * m)
        | VInt n, VVett x -> VVett (List.map (fun element -> element * n) x)
        | VVett x, VInt n -> VVett (List.map (fun element -> element * n) x)
        | VVett _, VVett _ -> failwith "errore di tipo: Vec * Vec non permesso"
        | _ -> failwith "errore in Mult"
      )
    | Ass(_,_) -> failwith "Ass non valutabile direttamente con eval"
  in
  let assegna env var e = (var, eval env e) :: env
  in
  let rec aux env = function
    | [] -> []
    | Ass(v, e) :: coda -> aux (assegna env v e) coda
    | e :: coda -> eval env e :: aux env coda
  in aux [] b


  (* PARTE DELLA STAMPA *)

  let stampaValore = function
  | VInt n -> print_int n; print_newline ()
  | VVett l ->
      print_string "[";
      List.iteri (fun i x ->
        if i > 0 then print_string ", ";
        print_int x) l;
      print_string "]";
      print_newline ()

let stampaLista l = List.iter stampaValore l

(* Stampa una espressione in notazione prefissa *)
let rec stampaespressione = function
  | Int n -> print_string "Int("; print_int n; print_string ")"
  | Var x -> print_string "Var("; print_string x; print_string ")"
  | Ass (s,e) ->
     print_string "ASS("; print_string s;
     print_string ", "; stampaespressione e;
     print_string ")"
  | Neg e -> 
      print_string "NEG("; stampaespressione e;
      print_string ")"
  | Sum (e1,e2) ->
      print_string "SUM("; stampaespressione e1;
      print_string ", "; stampaespressione e2;
      print_string ")"
  | Diff (e1,e2) ->
      print_string "DIFF("; stampaespressione e1;
      print_string ", "; stampaespressione e2;
      print_string ")"
  | Mult (e1,e2) ->
      print_string "MULT("; stampaespressione e1;
      print_string ", "; stampaespressione e2;
      print_string ")"
  | Vettore lst ->
      print_string "[";
      List.iteri (fun i e ->
        if i > 0 then print_string ", ";
        stampaespressione e) lst;
      print_string "]"

(* Stampa un blocco di espressioni in notazione prefissa *)
let stampablocco (Blocco b) =
  List.iter (fun x -> stampaespressione x; print_newline ()) b

(* Stampa una espressione in notazione infissa *)
let rec stampaespressioneinfissa = function
  | Int n -> print_int n
  | Var x -> print_string x
  | Ass (s,e) -> print_string s; print_string " := "; stampaespressioneinfissa e
  | Neg e -> print_string "-"; stampaespressioneinfissa e
  | Sum (e1,e2) ->
      print_string "(";
      stampaespressioneinfissa e1;
      print_string " + ";
      stampaespressioneinfissa e2;
      print_string ")"
  | Diff (e1,e2) ->
      print_string "(";
      stampaespressioneinfissa e1;
      print_string " - ";
      stampaespressioneinfissa e2;
      print_string ")"
  | Mult (e1,e2) ->
      print_string "(";
      stampaespressioneinfissa e1;
      print_string " * ";
      stampaespressioneinfissa e2;
      print_string ")"
  | Vettore lst ->
      print_string "[";
      List.iteri (fun i e ->
        if i > 0 then print_string ", ";
        stampaespressioneinfissa e) lst;
      print_string "]"

(* Stampa un blocco di espressioni in notazione infissa *)
let stampabloccoinfissa (Blocco b) =
  List.iter (fun x -> stampaespressioneinfissa x; print_newline ()) b
