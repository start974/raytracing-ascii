open Scene
open Gg

module To_test = struct
  let iter_scene = Screen.iter
end

module Helper = struct
  let camera = Camera.make P3.(v 0. 0. 0.) V3.(v 0. 0. 1.)

  let screen = Screen.make 3 2 0.5
end

let test_itter () =
  let expected = Queue.create () in
  let push_exp x y z = Queue.push (V3.v x y z) expected in
  push_exp (-0.75) 0.5 1. ;
  push_exp (-0.25) 0.5 1. ;
  push_exp 0.25 0.5 1. ;
  (* l2*)
  push_exp (-0.75) 0. 1. ;
  push_exp (-0.25) 0. 1. ;
  (* central point*)
  push_exp 0.25 0. 1. ;
  (* l3*)
  push_exp (-0.75) 0.5 1. ;
  push_exp (-0.25) 0.5 1. ;
  push_exp 0.25 (-0.5) 1. ;
  let printer s v =
    Printf.printf "%s: %f %f %f \n" s (V3.x v) (V3.y v) (V3.z v)
  in
  To_test.iter_scene Helper.screen Helper.camera (fun v ->
      let exp_v = Queue.pop expected in
      let equal = V3.equal v exp_v in
      if not equal then (
        printer "expected" exp_v ;
        printer "received" v ;
        Alcotest.(check bool) "position expected" true equal ) )

let () =
  let open Alcotest in
  run "screen" [("all", [test_case "test itter" `Quick test_itter])]
