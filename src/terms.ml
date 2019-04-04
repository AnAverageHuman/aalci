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

module VarSet = Set.Make (String)

(* 2.3.2 *)
let rec free_vars = function
  | Var x -> VarSet.singleton x
  | Abs (x, s) -> VarSet.diff (free_vars s) (VarSet.singleton x)
  | App (s, t) -> VarSet.union (free_vars s) (free_vars t)

let rec bound_vars = function
  | Var _ -> VarSet.empty
  | Abs (x, s) -> VarSet.union (bound_vars s) (VarSet.singleton x)
  | App (s, t) -> VarSet.union (bound_vars s) (bound_vars t)
