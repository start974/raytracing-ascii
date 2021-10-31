open Gg
open Scene
open Aux

module To_test = struct
  let middle_screen = Camera.middle_screen
end

let test_middle () =
  let camera = Camera.make P3.(v 1. 0. 0.) V3.(v 0. 1. 0.)
  and mid_expect = P3.v 1. 1. 0. in
  Alcotest.(check bool)
    "middle correct" true
    (let mid = To_test.middle_screen camera in
     V3.is_close mid mid_expect )

(*
let () =
  let open Alcotest in
  run "camera" [("all", [test_case "test middle" `Quick test_middle])]
*)