open Ast
open Lexing
open Printf

let parse_with_error lexbuf =
    try Parser.main Lexer.token lexbuf with
    | Parser.Error ->
        let pos = lexbuf.lex_curr_p in
        eprintf "Syntax error at line %d, column %d\n" pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1);
        exit (-1)

let rec evaluate = function
    | Int(n) -> n
    | Add(e1, e2) -> evaluate e1 + evaluate e2
    | Sub(e1, e2) -> evaluate e1 - evaluate e2
    | Mul(e1, e2) -> evaluate e1 * evaluate e2
    | Div(e1, e2) -> evaluate e1 / evaluate e2

let print ast =
    let rec print' ast depth =
        let tab = String.make depth ' ' in
        match ast with
        | Int(n) -> printf "%sInt(%d)\n" tab n
        | Add(e1, e2) -> printf "%sAdd(\n" tab; 
                         print' e1 (depth + 1); 
                         print' e2 (depth + 1); 
                         printf "%s)\n" tab
        | Sub(e1, e2) -> printf "%sSub(\n" tab; 
                         print' e1 (depth + 1); 
                         print' e2 (depth + 1);
                         printf "%s)\n" tab
        | Mul(e1, e2) -> printf "%sMul(\n" tab;
                         print' e1 (depth + 1);
                         print' e2 (depth + 1);
                         printf "%s)\n" tab
        | Div(e1, e2) -> printf "%sDiv(\n" tab;
                         print' e1 (depth + 1);
                         print' e2 (depth + 1);
                         printf "%s)\n" tab
    in print' ast 0


let () =
    let lexbuf = Lexing.from_channel stdin in
    let ast = parse_with_error lexbuf in
    print ast;
    printf "Result: %d\n" @@ evaluate ast

