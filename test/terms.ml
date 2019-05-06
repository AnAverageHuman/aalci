open Aalci.Terms

(* Variables *)
let var1 = Var "x"

let var2 = Var "y"

(* Abstractions *)
let abs1 = Abs ("x", Var "s")

let abs2 = Abs ("x", Abs ("y", Var "s"))

let abs3 = Abs ("m", Abs ("n", Abs ("f", Var "x")))

(* Applications *)
let app1 = App (Var "s", Var "t")

let app2 = App (App (Abs ("z", Var "z"), Abs ("x", Var "x")), Var "w")

let app3 =
  App (Abs ("x", Abs ("y", Var "x")), Abs ("x", App (Var "z", Var "x")))

let app4 = App (Abs ("f", App (Var "f", Var "f")), Abs ("x", Var "x"))
