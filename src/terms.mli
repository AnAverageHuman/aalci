(* Variable: x | Abstraction: λx.E | Application: EF *)
type term =
  | Var of string
  | Abs of string * term
  | App of term * term

val lambda_symb : string

val string_of_term : term -> string

val print_term : term -> unit
