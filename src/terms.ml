(* Introduction to Functional Programming, John Harrison *)

(* 2.3.1 *)
(* Variable: x | Abstraction: λx.E | Application: EF *)
type term =
  | Var of string
  | Abs of string * term
  | App of term * term

let lambda_symb = "λ"

let rec string_of_term =
  let open Printf in
  function
  | Var x -> x
  | Abs (x, s) -> sprintf "%s%s. %s" lambda_symb x (string_of_term s)
  | App (s, t) -> sprintf "(%s) (%s)" (string_of_term s) (string_of_term t)

let print_term x = x |> string_of_term |> print_endline
