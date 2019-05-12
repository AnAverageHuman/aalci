open Lexer

let parse_error_pos lexbuf =
  let open Lexing in
  let p = lexbuf.lex_curr_p in
  (* filename, line number, column number *)
  Printf.sprintf "%s at %d:%d" p.pos_fname p.pos_lnum (p.pos_cnum - p.pos_bol)

let parse lexbuf =
  let error_pos () = parse_error_pos lexbuf in
  try Parser.procedure Lexer.lex lexbuf with
  | SyntaxError msg ->
      Printf.fprintf stderr "%s in %s" msg (error_pos ()) ;
      Noop
  | Parser.Error ->
      Printf.fprintf stderr "syntax error in %s" (error_pos ()) ;
      exit (-1)

let lexbuf_channel = Lexing.from_channel

let lexbuf_string s = s ^ ";" |> Lexing.from_string

let read_program =
  let rec parse_step env routine lexbuf =
    let proc = parse lexbuf in
    match proc with
    | Def (id, t) -> parse_step (Program.EnvMap.add t id env) routine lexbuf
    | Use t -> parse_step env (t :: routine) lexbuf
    | Noop -> parse_step env routine lexbuf
    | Eof -> Program.{env; routine= routine |> List.rev}
  in
  parse_step Program.EnvMap.empty []

let rec substitute_env env t =
  let t' = Program.EnvMap.fold Terms.substitute env t in
  if t = t' then t else substitute_env env t'

let process_line env term =
  Terms.(term |> normalize |> substitute_env env |> normalize |> print_term)

let rec execute Program.{env; routine} =
  match routine with
  | [] -> ()
  | hd :: tl ->
      process_line env hd ;
      execute {env; routine= tl}
