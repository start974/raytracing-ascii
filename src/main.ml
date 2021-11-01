open Output
open Geometry
open Gg
open Aux
open Scene

let minimal_scene () =
  let screen = Screen.make 700 700 1. in
  let camera = Camera.make P3.(v 0. 0. 0.) V3.(v 0. 0. 2.) screen
  and ambiant = Color.(v_srgb 0.4 0.4 0.4)
  and lights : Light.t array =
    [| { position= P3.v (-15.) (0.) 30.
       ; diffuse= 500. * Color.white
       ; specular= 500. * Color.white
       ; shiness= 100. }
     ; { position= P3.v (-15.) 0. 20.
       ; diffuse= 500 * Color.white
       ; specular= 500 * Color.white
       ; shiness= 100. } |]
  and objects =
    Object.
      [| make
           (Sphere.v P3.(v 1. 0.5 0.5) 1.)
           { ka= Color.v_srgb 0. 0. 0.1
           ; kd= Color.v_srgb 0.9 0. 0.
           ; ks= Color.v_srgb 0.9 0. 0.8 }
       ; make
           (Sphere.v P3.(v 3. 1. 19.) 1.)
           { ka= Color.v_srgb 0. 0.1 0.
           ; kd= Color.v_srgb 0. 0.9 0.
           ; ks= Color.white }
       ; make
           (Sphere.v P3.(v 0. 12. 50.) 12.)
           { ka= Color.v_srgb 0.0 0.1 0.5
           ; kd= Color.v_srgb 0.1 0.4 0.9
           ; ks= Color.v_srgb 0.1 0.9 0.1 } |]
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
