open Lexing
open Printf

let parse_with_error lexbuf =
  try Parser.main Lexer.token lexbuf with
  | Parser.Error ->
    let pos = lexbuf.lex_curr_p in
    eprintf "Syntax error at line %d, column %d\n" pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1);
    exit (-1)

let () =
  let lexbuf = Lexing.from_channel stdin in
  let result = parse_with_error lexbuf in
  printf "Result: %d\n" result
