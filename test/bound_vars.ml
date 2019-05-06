open Aalci.Terms

let%test _ = VarSet.equal (Terms.var1 |> bound_vars) VarSet.empty

let%test _ = VarSet.equal (Terms.var2 |> bound_vars) VarSet.empty

let%test _ =
  VarSet.equal (Terms.abs1 |> bound_vars)
    (List.fold_right VarSet.add ["x"] VarSet.empty)

let%test _ =
  VarSet.equal (Terms.abs2 |> bound_vars)
    (List.fold_right VarSet.add ["x"; "y"] VarSet.empty)

let%test _ =
  VarSet.equal (Terms.abs3 |> bound_vars)
    (List.fold_right VarSet.add ["m"; "n"; "f"] VarSet.empty)

let%test _ = VarSet.equal (Terms.app1 |> bound_vars) VarSet.empty

let%test _ =
  VarSet.equal (Terms.app2 |> bound_vars)
    (List.fold_right VarSet.add ["z"; "x"] VarSet.empty)

let%test _ =
  VarSet.equal (Terms.app3 |> bound_vars)
    (List.fold_right VarSet.add ["x"; "y"] VarSet.empty)
