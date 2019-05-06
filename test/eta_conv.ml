open Aalci.Terms

let%test _ = Abs ("x", App (Var "t", Var "x")) |> eta_conv = Var "t"

let%test _ = Abs ("u", App (Var "v", Var "u")) |> eta_conv = Var "v"

let not_etaconvable = Abs ("u", App (Var "u", Var "u"))

let%test "etaconv3" = not_etaconvable |> eta_conv = not_etaconvable
