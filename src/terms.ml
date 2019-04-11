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

let alphaset = List.fold_right VarSet.add Misc.alphalist VarSet.empty

let fresh_var set = VarSet.diff alphaset set |> VarSet.choose

(* 2.3.3 *)
(* s[tt/xx] *)
let rec substitute tt xx = function
  | Var x -> if x = xx then tt else Var x
  | Abs (y, s) ->
      if xx = y then Abs (y, s) (* λx.s *)
      else if
        (not (VarSet.mem xx (free_vars s)))
        || not (VarSet.mem y (free_vars tt))
      then Abs (y, substitute tt xx s) (* λy.(s[t/x]) *)
      else
        let z = fresh_var (VarSet.union (free_vars s) (free_vars tt)) in
        Abs (z, s |> substitute (Var z) y |> substitute tt xx)
        (* λz.(s[z/y][t/x]) *)
  | App (s, t) -> App (substitute tt xx s, substitute tt xx t)
