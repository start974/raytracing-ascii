open Output
open Geometry
open Gg
open Aux
open Scene

let minimal_scene () =
  let screen = Screen.make 700 700 1. in
  let camera = Camera.make P3.(v 0. 0. 0.) V3.(v 0. 0. 2.) screen
  and ambiant = Color.(v_srgb 0.3 0.3 0.3)
  and lights = [|Light.make Color.(v_srgb 0.7 0.7 0.7) P3.(v 10. 10. 10.)|]
  and objects =
    Object.
      [| make (Sphere.v P3.(v 0. 0. 25.) 1.) Color.red
       ; make (Sphere.v P3.(v (-2.) 2. 20.) 0.5) Color.blue
       ; make (Sphere.v P3.(v 0. 12. 100.) 12.) Color.green |]
  in
  Scene.make camera ambiant lights objects

let () =
  let scene = minimal_scene () in
  let width, height = (700, 700) in
  let image =
    Image_PPM.init width height (fun y x ->
        let color_scene = Scene.get_color scene x y in
        Color.int_triple color_scene )
  in
  let file = open_out "test.ppm" in
  Image_PPM.write image file ; close_out file
