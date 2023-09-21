%{
    open Ast
%}

%token <int> INT
%token LPAREN RPAREN
%token PLUS MINUS TIMES DIVIDE
%token EOF

%start main
%type <ast> main
%type <ast> ast

%%

main:
    | ast EOF { $1 }

ast:
    | INT { Int($1) }
    | LPAREN ast RPAREN { $2 }
    | ast PLUS ast   { Add($1, $3) }
    | ast MINUS ast  { Sub($1, $3) }
    | ast TIMES ast  { Mul($1, $3) }
    | ast DIVIDE ast { Div($1, $3) }

