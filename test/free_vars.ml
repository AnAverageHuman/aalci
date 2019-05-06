open Aalci.Terms

let%test _ =
  VarSet.equal (Terms.var1 |> free_vars)
    (List.fold_right VarSet.add ["x"] VarSet.empty)

let%test _ =
  VarSet.equal (Terms.var2 |> free_vars)
    (List.fold_right VarSet.add ["y"] VarSet.empty)

let%test _ =
  VarSet.equal (Terms.abs1 |> free_vars)
    (List.fold_right VarSet.add ["s"] VarSet.empty)

let%test _ =
  VarSet.equal (Terms.abs2 |> free_vars)
    (List.fold_right VarSet.add ["s"] VarSet.empty)

let%test _ =
  VarSet.equal (Terms.abs3 |> free_vars)
    (List.fold_right VarSet.add ["x"] VarSet.empty)

let%test _ =
  VarSet.equal (Terms.app1 |> free_vars)
    (List.fold_right VarSet.add ["s"; "t"] VarSet.empty)

let%test _ =
  VarSet.equal (Terms.app2 |> free_vars)
    (List.fold_right VarSet.add ["w"] VarSet.empty)

let%test _ =
  VarSet.equal (Terms.app3 |> free_vars)
    (List.fold_right VarSet.add ["z"] VarSet.empty)
