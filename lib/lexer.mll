{
  open Parser

  exception SyntaxError of string
}

let digit = ['0' - '9']
let alpha = ['a' - 'z' 'A' - 'Z']
let white = [' ' '\t' '\n']+

rule lex = parse
  | ":=" | "≔"                    { DEFINE }
  | "\\" | "λ"                    { LAMBDA }
  | "("                           { LPAREN }
  | ")"                           { RPAREN }
  | "."                           { DOT }
  | ";"                           { SEMICO }
  | white                         { lex lexbuf }
  | alpha (alpha | digit)* as id  { VAR id }
  | eof                           { EOF }
  | _                             { raise (SyntaxError ("Unexpected char " ^
                                      (lexbuf |> Lexing.lexeme |> String.escaped
                                      ))) }
