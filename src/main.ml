open Output
open Geometry
open Gg
open Aux
open Scene

let minimal_scene () =
  let screen = Screen.make 700 700 1. in
  let camera = Camera.make P3.(v 0. 0. 0.) V3.(v 0. 0. 2.) screen
  and ambiant = Color.(v_srgb 0.4 0.4 0.4)
  and lights =
    [| Light.make V4.(500. * Color.(v_srgb 1. 1. 1.)) P3.(v (-15.) 0. 30.)
     ; Light.make V4.(250. * Color.(v_srgb 1. 1. 1.)) P3.(v (-15.) 0. 20.) |]
  and objects =
    Object.
      [| make (Sphere.v P3.(v 0. 0. 20.) 1.5) Color.(v_srgb 1. 0.5 0.5) 1.
       ; make (Sphere.v P3.(v 3. 1. 19.) 1.) Color.(v_srgb 0.5 1. 0.5) 1.
       ; make (Sphere.v P3.(v 0. 12. 50.) 12.) Color.(v_srgb 0.5 0.5 1.) 1. |]
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
