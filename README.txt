# ODromedr
## Intro

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
