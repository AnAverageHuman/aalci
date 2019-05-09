open Aalci

let get_lexbuf () =
  match Array.to_list Sys.argv with
  | _ :: fn :: _ -> fn |> open_in
  | _ -> stdin

let () = Functions.(get_lexbuf () |> lexbuf_channel |> read_program |> execute)
