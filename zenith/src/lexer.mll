{
  open Parser
}

rule token = parse
  | [' ' '\t' '\n']    { token lexbuf } (* skip whitespace for now *)
  | '('                { LPAREN }
  | ')'                { RPAREN }
  | '+'                { PLUS }
  | '-'                { MINUS }
  | '*'                { TIMES }
  | '/'                { DIVIDE }
  | ['0'-'9']+ as num  { INT (int_of_string num) }
  | eof                { EOF }
  | _                  { failwith ("Invalid character when lexing: " ^ Lexing.lexeme lexbuf) }

