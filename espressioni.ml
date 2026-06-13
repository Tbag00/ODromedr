(* Risultato della valutazione *)
type valore =
  | VInt of int
  | VVett of int list

(* Per costruzione albero sintattico *)
type espressione =
  | Int of int
  | Var of string
  | Ass of string * espressione
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
