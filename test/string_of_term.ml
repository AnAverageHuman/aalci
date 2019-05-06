open Aalci.Terms

let%test _ = Terms.var1 |> string_of_term = "x"

let%test _ = Terms.var2 |> string_of_term = "y"

let%test _ = Terms.abs1 |> string_of_term = "λx. s"

let%test _ = Terms.abs2 |> string_of_term = "λx. λy. s"

let%test _ = Terms.abs3 |> string_of_term = "λm. λn. λf. x"

let%test _ = Terms.app1 |> string_of_term = "s t"

let%test _ = Terms.app2 |> string_of_term = "((λz. z) (λx. x)) w"

let%test _ = Terms.app3 |> string_of_term = "(λx. λy. x) (λx. z x)"
