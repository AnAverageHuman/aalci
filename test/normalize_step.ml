open Aalci.Terms

let%test _ =
  Terms.app3 |> normalize_step = Abs ("y", Abs ("x", App (Var "z", Var "x")))

let normalize4_1 = Terms.app4 |> normalize_step

let%test _ = normalize4_1 = App (Abs ("x", Var "x"), Abs ("x", Var "x"))

let normalize4_2 = normalize4_1 |> normalize_step

let%test _ = normalize4_2 = Abs ("x", Var "x")

let%test _ = normalize4_2 |> normalize_step = normalize4_2
