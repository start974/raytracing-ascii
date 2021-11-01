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
    [| { position= P3.v 5. 5. 5.
       ; diffuse= V4.(200. * Color.white)
       ; specular= V4.(200. * Color.green)
       ; shiness= 100. }
     ; { position= P3.v (-5.) (-5.) 5.
       ; diffuse= V4.(2000. * Color.white)
       ; specular= V4.(200. * Color.white)
       ; shiness= 100. } |]
  and objects =
    Object.
      [| make
           (Sphere.v P3.(v 3. 3. 25.) 1.)
           { ka= Color.v_srgb 0.8 0. 0.0
           ; kd= Color.v_srgb 0.9 0. 0.
           ; ks= Color.v_srgb 0.4 0. 0.
           ; reflexivity= 1. }
       ; make
           (Sphere.v P3.(v 3. (-3.) 25.) 1.)
           { ka= Color.v_srgb 0. 0.9 0.
           ; kd= Color.v_srgb 0. 0.7 0.
           ; ks= Color.white
           ; reflexivity= 1. }
       ; make
           (Sphere.v P3.(v (-3.) 3. 25.) 1.)
           { ka= Color.v_srgb 0.0 0.8 0.5
           ; kd= Color.v_srgb 0.1 0.4 0.9
           ; ks= Color.white
           ; reflexivity= 1. }
       ; make
           (Sphere.v P3.(v (-3.) (-3.) 25.) 1.)
           { ka= Color.v_srgb 0.9 0.9 0.9
           ; kd= Color.v_srgb 0.9 0.9 0.9
           ; ks= Color.white
           ; reflexivity= 1. } |]
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
