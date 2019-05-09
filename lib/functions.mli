val lexbuf_channel : in_channel -> Lexing.lexbuf

val lexbuf_string : string -> Lexing.lexbuf

val read_program : Lexing.lexbuf -> Program.program

val execute : Program.program -> unit
