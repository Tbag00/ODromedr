(* File lexer.mll *) 
{ 
open Parser (* The type token is defined in parser.mli *)
exception Eof 
} 

rule token = parse 
[' ' '\t' '\n' ] { token lexbuf } (* skip blanks *)  
| ['0'-'9']+ as lxm { INT(int_of_string lxm) } 
| ":=" { ASSEGNA }
| ['a'-'z''A'-'Z']['a'-'z''A'-'Z''0'-'9''_']* as lxm { VAR(lxm) }
| '+' { PLUS } 
|'-' { MINUS } 
|'*' { TIMES } 
| '(' { LPAREN } 
| ')' { RPAREN } 
| '{' { INIZIOBLOCCO } 
| '}' { FINEBLOCCO } 
| '[' { INIZIOVEC } 
| ']' { FINEVEC } 
| ';' { SEMICOLON }
| ',' { COMMA }
| eof { EOF}
