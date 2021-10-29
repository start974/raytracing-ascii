open Output
open Geometry
open Gg
open Aux
open Scene

let minimal_scene () =
  let camera = Camera.make P3.(v 0. 0. 0.) V3.(v 0. 0. 1.)
  and screen = Screen.make 700 700 0.07
  and ambiant = Lights.AmbiantLight.make 1 1 1 in
  let lights = Lights.make ambiant
  and objects =
    Scene.Objects.ObjectScene.(
      Objects.make
        [ make (Sphere.v P3.(v 0. 0. 25.) 20.) V3.(v 0. 10. 200.)
        ; make (Sphere.v P3.(v 60. 60. 25.) 12.) V3.(v 0. 200. 0.) ])
  in
  Scene.make camera screen lights objects

let () =
  let scene = minimal_scene () in
  let width, height = Scene.screen_size scene in
  let image =
    Image_PPM.init width height (fun y x ->
        let color_scene = Scene.get_color scene x y in
        V3.to_triple_int color_scene )
  in
  let file = open_out "test.ppm" in
  Image_PPM.write image file ; close_out file
