open Output
open Geometry
open Gg
open Scene

let minimal_scene () =
  let camera = Camera.make P3.(v 0. 0. 0.) P3.(v 0. 1. 0.)
  and screen = Screen.make 960 530 (16. /. 9.)
  and ambiant = Lights.AmbiantLight.make 1 1 1 in
  let lights = Lights.make ambiant
  and objects =
    Objects.make
      [ Scene.Objects.ObjectScene.(
          make (Sphere.v P3.(v 0. 5. 0.) 3.) V3.(v 255. 0. 0.)) ]
  in
  Scene.make camera screen lights objects

let make_image_empty scene =
  let screen = get_screen scene in
  let height = Screen.get_width screen and width = Screen.get_width screen in
  Image_PPM.make width height (0, 0, 0)

let () =
  let scene = minimal_scene () in
  let image = make_image_empty scene in
  let buffer_image = Image_PPM.Buffered.make image in
  Scene.iter_ray scene (fun ray -> 
    let color_scene = Scene.compute_color scene ray in
    let color_image = V3.to_triple_int color_scene in
    Image_PPM.Buffered.add_pixel buffer_image color_image
  )
  let image_fill = Image_PPM.Buffered.get_image buffer_image in
  Image_PPM.write image_fill Stdlib.stdout

(*
  iter_ray ok
  iter_pixel
    - launch iter_ray 
      - f ray scen
        - ne
  *)