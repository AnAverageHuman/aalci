(* Variable: x | Abstraction: λx.E | Application: EF *)
type term =
  | Var of string
  | Abs of string * term
  | App of term * term

val lambda_symb : string

val string_of_term : term -> string

val print_term : term -> unit

module VarSet : sig
  type elt = string

  type t

  val empty : t

  val add : elt -> t -> t
end

val free_vars : term -> VarSet.t

val bound_vars : term -> VarSet.t

val substitute : term -> string -> term -> term
(** [substitute tt xx] replaces all instances of xx with tt in a given term. *)

val alpha_conv : term -> term

val beta_conv : term -> term

val eta_conv : term -> term
