%token <int> INT
%token <string> VAR
%token PLUS MINUS TIMES
%token LPAREN RPAREN
%token INIZIOVEC FINEVEC
%token COMMA
%token ASSEGNA
%token SEMICOLON
%token INIZIOBLOCCO
%token FINEBLOCCO
%token EOF

%left PLUS MINUS      /* precedenza più bassa */
%left TIMES           /* precedenza più alta */
%nonassoc UMINUS      /* precedenza massima */

%start main
%type <Espressioni.blocco option> main

%%

main:
  | INIZIOBLOCCO espressioni FINEBLOCCO
      { Some (Espressioni.Blocco $2) }
  | EOF
      { None }
;

espressioni:  (* Lista di espressioni dentro un blocco {} *)
  | espressione
      { [$1] }
  | espressione espressioni
      { $1 :: $2 }
;

espressione:
  | expr SEMICOLON
      { $1 }
;

expr:
  | INT
      { Espressioni.Int $1 }
  | VAR
      { Espressioni.Var $1 }
  | VAR ASSEGNA expr
      { Espressioni.Ass($1, $3) }
  | LPAREN expr RPAREN
      { $2 }
  | INIZIOVEC listaexpr FINEVEC
      { Espressioni.Vettore $2 }
  | MINUS expr %prec UMINUS
    { Espressioni.Neg $2 }
  | expr PLUS expr
      { Espressioni.Sum($1, $3) }
  | expr MINUS expr
      { Espressioni.Diff($1, $3) }
  | expr TIMES expr
      { Espressioni.Mult($1, $3) }
  | MINUS expr %prec UMINUS
      { Espressioni.Diff(Espressioni.Int 0, $2) }
;

listaexpr:  (* Lista di espressioni dentro un vettore [] *)
  | expr
      { [$1] }
  | expr COMMA listaexpr
      { $1 :: $3 }
  |
      { [] }
;
