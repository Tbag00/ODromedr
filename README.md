# ODromedr

ODromdr è un linguaggio interpretato il cui obiettivo è quello di fare semplici operazioni su vettori

L'interprete è scritto in OCaml
##   TODO
cambia la struttura della grammatica
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

ocamlc -o ODromedr espressioni.cmo Lexer.cmo parser.cmo main.cmo

### Come compilare i programmi di stampa
ocamlc -c outputLexer.ml

ocamlc -o outputLexer espressioni.cmo Lexer.cmo parser.cmo outputLexer.cmo


ocamlc -c outputParser.ml

ocamlc -o outputParser espressioni.cmo Lexer.cmo parser.cmo outputParser.cmo


ocamlc -c outputParserInfissa.ml

ocamlc -o outputParserInfissa espressioni.cmo Lexer.cmo parser.cmo outputParserInfissa.cmo


## Testing
Abbiamo lasciato dei file di esempio input?.txt per testare il corretto funzionamento del programma
