type procedure =
  | Def of string * Terms.term
  | Use of Terms.term
  | Noop
