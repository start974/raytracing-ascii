open Output
open Gg
open Aux
open Scene

let minimal_scene width height =
  let screen = Screen.make width height 1. in
  let camera = Camera.make P3.(v 0. 0. 0.) V3.(v 0. 0. 2.) screen
  and ambiant = Color.(v_srgb 0.2 0.2 0.2)
  and lights : Light.t array =
    [| { position= P3.v 5. 10. 0.
       ; diffuse= V4.(500. * Color.white)
       ; specular= V4.(500. * Color.white)
       ; shiness= 100. }
     ; { position= P3.v 3. (-2.) 5.
       ; diffuse= V4.(500. * Color.white)
       ; specular= V4.(500. * Color.white)
       ; shiness= 100. } |]
  and objects =
    Object.
      [| (* purple plain *)
         plane
           P3.(v 0. (-10.) 0.)
           P3.(v 0. (-1.) 0.)
           { ka= Color.v_srgb 0.5 0. 0.9
           ; kd= Color.v_srgb 0.4 0. 0.8
           ; ks= V4.(0.2 * Color.white)
           ; reflexivity= 0.4
           ; refraction_index= 0.8
           ; opacity= 1. }
         (*;triangle
            P3.(v (-0.) (-2.) 15.)
            P3.(v (-1.) 3. 10.)
            P3.(v 2. 0. 20.)
            { ka= Color.v_srgb 0.9 0.5 0.9
            ; kd= Color.v_srgb 0.7 0.2 0.7
            ; ks= V4.(0.8 * Color.white)
            ; reflexivity= 1.
            ; refraction_index= 1.
            ; opacity= 1. }
         *)
       ; (*sphere bleu arriere plan *)
         sphere
           P3.(v 0. 0. 50.)
           12.
           { ka= Color.v_srgb 0. 0.9 0.9
           ; kd= Color.v_srgb 0. 0.7 0.7
           ; ks= V4.(0.5 * Color.white)
           ; reflexivity= 1.
           ; refraction_index= 1.
           ; opacity= 1. }
       ; (* sphere transparente *)
         sphere
           P3.(v 0. 0. 10.)
           0.5
           { ka= Color.black
           ; kd= Color.white
           ; ks= V4.(0.5 * Color.white)
           ; reflexivity= 0.
           ; refraction_index= 1.5
           ; opacity= 0.00 }
       ; (* sphere jaune avec moin de spécular*)
         sphere
           P3.(v 3. 3. 25.)
           1.
           { ka= Color.v_srgb 0.9 0.8 0.
           ; kd= Color.v_srgb 0.9 0.8 0.
           ; ks= V4.(0.5 * Color.white)
           ; reflexivity= 0.8
           ; refraction_index= 0.
           ; opacity= 0.8 }
       ; (* sphere verte *)
         sphere
           P3.(v 3. (-3.) 25.)
           1.
           { ka= Color.v_srgb 0. 0.9 0.
           ; kd= Color.v_srgb 0. 0.7 0.
           ; ks= Color.white
           ; reflexivity= 1.
           ; refraction_index= 0.
           ; opacity= 1. }
       ; (* sphere bleu *)
         sphere
           P3.(v (-3.) 3. 25.)
           1.
           { ka= Color.v_srgb 0.0 0.8 0.5
           ; kd= Color.v_srgb 0.1 0.4 0.9
           ; ks= Color.white
           ; reflexivity= 1.
           ; refraction_index= 0.
           ; opacity= 1. }
       ; (* shere rouge *)
         sphere
           P3.(v (-3.) (-3.) 25.)
           1.
           { ka= Color.v_srgb 0.9 0. 0.
           ; kd= Color.v_srgb 0.7 0. 0.
           ; ks= Color.white
           ; reflexivity= 1.
           ; refraction_index= 0.
           ; opacity= 1. } |]
  in
  Scene.make camera ambiant lights objects

let image_ppm () =
  let width, height = (700, 700) in
  let scene = minimal_scene width height in
  let image =
    Image_PPM.init width height (fun y x ->
        let color_scene = Scene.get_color scene x y in
        Color.int_triple color_scene )
  in
  let file = open_out "test.ppm" in
  Image_PPM.write image file ; close_out file

let image_pgm () =
  let width, height = (700, 700) in
  let scene = minimal_scene width height in
  let image =
    Image_PGM.init width height (fun y x ->
        let color_scene = Scene.get_color scene x y in
        let gray = Color.to_gray color_scene in
        Float.(to_int (gray * 15.)) )
  in
  let file = open_out "test.pgm" in
  Image_PGM.write image file ; close_out file

let image_ascii () =
  let width, height = (200, 200) in
  let scene = minimal_scene width height in
  let chars =
    "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\\|()1{}[]?-_+~<>i!lI;:,\"^`'. "
  in
  let pixel_maker = MkPixel_ascii.make chars in
  let image =
    Image_ascii.init width height (fun y x ->
        let color_scene = Scene.get_color scene x y in
        let gray = Color.to_gray color_scene in
        MkPixel_ascii.create_pixel pixel_maker gray )
  in
  Image_ascii.write image stdout

let () = image_ppm ()

