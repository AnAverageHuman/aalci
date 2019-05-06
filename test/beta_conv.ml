open Aalci.Terms

let%test _ = Terms.var1 |> beta_conv = Terms.var1

let%test _ = Terms.var2 |> beta_conv = Terms.var2

let%test _ = Terms.abs1 |> beta_conv = Terms.abs1

let%test _ = Terms.abs2 |> beta_conv = Terms.abs2

let%test _ = Terms.abs3 |> beta_conv = Terms.abs3

let%test _ = Terms.app1 |> beta_conv = Terms.app1

let%test _ = Terms.app2 |> beta_conv = Terms.app2

let%test _ =
  Terms.app3 |> beta_conv = Abs ("y", Abs ("x", App (Var "z", Var "x")))
