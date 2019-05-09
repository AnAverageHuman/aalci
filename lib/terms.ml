(* Introduction to Functional Programming, John Harrison *)

(* 2.3.1 *)
(* Variable: x | Abstraction: λx.E | Application: EF *)
type term =
  | Var of string
  | Abs of string * term
  | App of term * term

let lambda_symb = "λ"

let rec string_of_term = function
  | Var s -> s
  | Abs (x, s) -> Printf.sprintf "%s%s. %s" lambda_symb x (string_of_term s)
  | App (s, t) -> Printf.sprintf "%s %s" (string_of_exp s) (string_of_exp t)

and string_of_exp = function
  | Var s -> s
  | t -> Printf.sprintf "(%s)" (string_of_term t)

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

(* 2.3.4 *)
(* λx. s -> λy. s[y/x], y not in FV(s) *)
let alpha_conv = function
  | Abs (x, s) ->
      let y = free_vars s |> fresh_var in
      Abs (y, substitute (Var y) x s)
  | t -> t

(* (λx. s) t -> s[t/x] *)
let beta_conv = function
  | App (Abs (x, s), t) -> substitute t x s
  | t -> t

(* λx.t x -> t, if x not in FV(t) *)
let eta_conv = function
  | Abs (x, App (t1, t2)) ->
      if VarSet.mem x (free_vars t1) then Abs (x, App (t1, t2)) else t1
  | t -> t

(* 2.3.8 *)
(* (λx.s) t *)
let rec normalize_step = function
  | App (Abs (x, s), t) -> beta_conv (App (Abs (x, s), t))
  | App (s, t) ->
      (* if left can't be reduced, try right *)
      let s' = normalize_step s in
      if s = s' then App (s, normalize_step t) else App (s', t)
  | Abs (x, s) -> Abs (x, normalize_step s)
  | t -> t

let rec normalize t =
  let t' = normalize_step t in
  print_term t ;
  if t = t' then t else normalize t'
