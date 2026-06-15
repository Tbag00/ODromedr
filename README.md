# ODromedr

ODromdr è un linguaggio interpretato il cui obiettivo è quello di fare semplici operazioni su vettori

L'interprete è scritto in OCaml
## Grammatica
A = { '{', '}', '[', ']', ',', ';', ':=', '+', '-', '*', '(', ')', VAR, INT }
V = { Blocco, ListaStmt, Stmt, Expr, Vettore, ListaInt }
S = Blocco

P:
Blocco    ::= '{' ListaStmt '}'

ListaStmt ::= Stmt
            | Stmt ListaStmt

Stmt      ::= VAR ':=' Expr ';'
            | Expr ';'

Expr      ::= Expr '+' Expr
            | Expr '-' Expr
            | Expr '*' Expr
            | INT '*' Expr
            | Expr '*' INT
            | '(' Expr ')'
            | Vettore
            | VAR
            | INT

Vettore   ::= '[' ListaInt ']'
            | '[' ']'

ListaInt  ::= Expr
            | Expr ',' ListaInt

## Come compilare
ocamlc -c espressioni.ml
ocamlyacc parser.mly
ocamlc -c parser.mli
ocamllex Lexer.mll
ocamlc -c Lexer.ml
ocamlc -c parser.ml
ocamlc -c main.ml
ocamlc -o programma.exe espressioni.cmo Lexer.cmo parser.cmo main.cmo

## Testing
Abbiamo lasciato dei file di esempio input?.txt per testare il corretto funzionamento del programma
