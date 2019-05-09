{
  open Parser

  exception SyntaxError of string

  let next_line lb =
    let open Lexing in
    let p = lb.lex_curr_p in
    lb.lex_curr_p <- {p with pos_bol= lb.lex_curr_pos; pos_lnum= p.pos_lnum + 1}
}

let digit = ['0' - '9']
let alpha = ['a' - 'z' 'A' - 'Z']
let white = [' ' '\t']+

rule lex = parse
  | ":=" | "≔"                    { DEFINE }
  | "\\" | "λ"                    { LAMBDA }
  | "("                           { LPAREN }
  | ")"                           { RPAREN }
  | "."                           { DOT }
  | ";"                           { SEMICO }
  | alpha (alpha | digit)* as id  { VAR id }
  | "\n"                          { next_line lexbuf; lex lexbuf }
  | white                         { lex lexbuf }
  | eof                           { EOF }
  | _                             { raise (SyntaxError ("Unexpected char " ^
                                      (lexbuf |> Lexing.lexeme |> String.escaped
                                      ))) }
