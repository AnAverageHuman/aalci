type procedure =
  | Def of string * Terms.term
  | Use of Terms.term
  | Noop
  | Eof

module EnvMap = Map.Make (struct
  type t = Terms.term

  let compare = compare
end)

type program =
  { env: string EnvMap.t
  ; routine: Terms.term list }
