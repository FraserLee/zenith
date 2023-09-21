%token <int> INT
%token LPAREN RPAREN
%token PLUS MINUS TIMES DIVIDE
%token EOF

%start main
%type <int> main

%%

main:
  | expr EOF { $1 }

expr:
  | INT { $1 }
  | LPAREN expr RPAREN { $2 }
  | expr PLUS expr  { $1 + $3 }
  | expr MINUS expr { $1 - $3 }
  | expr TIMES expr { $1 * $3 }
  | expr DIVIDE expr { $1 / $3 }

