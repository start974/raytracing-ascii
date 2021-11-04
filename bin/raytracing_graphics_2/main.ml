open Gg
open Aux
open Scene
open Geometry
open Graphics

let minimal_scene width height =
  let screen = Screen.make width height 1. in
  let camera = Camera.make P3.(v 0. 0. 5.) V3.(v 0. 1. 0.) screen
  and ambiant = Color.(v_srgb 0.2 0.2 0.2)
  and lights : Light.t array =
    [| { position= P3.v (-5.) 10. 30.
       ; diffuse= V4.(500. * Color.white)
       ; specular= V4.(500. * Color.white)
       ; shiness= 100. }
     ; { position= P3.v 5. 10. 0.
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
           P3.(v 0. 0. (-10.))
           P3.(v 0. 0. (-1.))
           { ka= Color.v_srgb 0.5 0. 0.9
           ; kd= Color.v_srgb 0.4 0. 0.8
           ; ks= V4.(0.2 * Color.white)
           ; reflexivity= 0.4
           ; refraction_index= 0.8
           ; opacity= 1. }
       ; (*sphere bleu arriere plan *)
         sphere
           P3.(v 10. 30. 10.)
           5.
           { ka= Color.red
           ; kd= Color.red
           ; ks= V4.(0.2 * Color.white)
           ; reflexivity= 1.
           ; refraction_index= 2.
           ; opacity= 0.3 }
       ; sphere
           P3.(v 0. 30. 0.)
           8.
           { ka= Color.black
           ; kd= Color.black
           ; ks= V4.(0.2 * Color.white)
           ; reflexivity= 1.
           ; refraction_index= 1.
           ; opacity= 1. }
       ; (* sphere transparente *)
         sphere
           P3.(v 0. 10. 0.)
           0.5
           { ka= Color.black
           ; kd= Color.white
           ; ks= V4.(0.5 * Color.white)
           ; reflexivity= 0.
           ; refraction_index= 1.5
           ; opacity= 0.00 }
       ; (* sphere jaune avec moin de spécular*)
         sphere
           P3.(v 3. 20. 5.)
           2.
           { ka= Color.v_srgb 0.9 0.8 0.
           ; kd= Color.v_srgb 0.9 0.8 0.
           ; ks= V4.(0.5 * Color.white)
           ; reflexivity= 0.8
           ; refraction_index= 0.
           ; opacity= 0.8 }
       ; (* sphere verte *)
         sphere
           P3.(v 3. 20. (-3.))
           1.
           { ka= Color.v_srgb 0. 0.9 0.
           ; kd= Color.v_srgb 0. 0.7 0.
           ; ks= Color.white
           ; reflexivity= 1.
           ; refraction_index= 0.
           ; opacity= 1. }
       ; (* sphere bleu *)
         sphere
           P3.(v (-3.) 20. 3.)
           1.
           { ka= Color.v_srgb 0.0 0.8 0.5
           ; kd= Color.v_srgb 0.1 0.4 0.9
           ; ks= Color.white
           ; reflexivity= 1.
           ; refraction_index= 0.
           ; opacity= 1. }
       ; (* shere rouge *)
         sphere
           P3.(v (-3.) 20. (-3.))
           1.
           { ka= Color.v_srgb 0.9 0. 0.
           ; kd= Color.v_srgb 0.7 0. 0.
           ; ks= Color.white
           ; reflexivity= 1.
           ; refraction_index= 0.
           ; opacity= 1. } |]
  in
  Scene.make camera ambiant lights objects

let x_def = 1000

let y_def = 1000

let upscaling = 1

let () =
  open_graph
    (String.concat ""
       [ " "
       ; string_of_int (x_def * upscaling)
       ; "x"
       ; string_of_int (y_def * upscaling) ] )

let scene = ref (minimal_scene x_def y_def)

let get_camera () = Scene.camera !scene

let up = V3.v 0. 0. 1.

let move_forward () =
  let camera = get_camera () in
  let forward = Camera.forward camera in
  let position = Camera.position camera in
  let position = V3.(position + (1. * unit forward)) in
  let camera = Camera.replaced ~position camera in
  scene := Scene.replaced ~camera !scene

let move_backward () =
  let camera = get_camera () in
  let forward = Camera.forward camera in
  let position = Camera.position camera in
  let position = V3.(position - (1. * unit forward)) in
  let camera = Camera.replaced ~position camera in
  scene := Scene.replaced ~camera !scene

let move_left () =
  let camera = get_camera () in
  let position = Camera.position camera in
  let fx, _fy = Plane.frame ~up (Camera.screen_plane camera) in
  let position = V3.(position + (1. * unit fx)) in
  let camera = Camera.replaced ~position camera in
  scene := Scene.replaced ~camera !scene

let move_right () =
  let camera = get_camera () in
  let position = Camera.position camera in
  let fx, _fy = Plane.frame ~up (Camera.screen_plane camera) in
  let position = V3.(position - (1. * unit fx)) in
  let camera = Camera.replaced ~position camera in
  scene := Scene.replaced ~camera !scene

let move_up () =
  let camera = get_camera () in
  let position = Camera.position camera in
  let _fx, fy = Plane.frame ~up (Camera.screen_plane camera) in
  let position = V3.(position + (1. * unit fy)) in
  let camera = Camera.replaced ~position camera in
  scene := Scene.replaced ~camera !scene

let move_down () =
  let camera = get_camera () in
  let position = Camera.position camera in
  let _fx, fy = Plane.frame ~up (Camera.screen_plane camera) in
  let position = V3.(position - (1. * unit fy)) in
  let camera = Camera.replaced ~position camera in
  scene := Scene.replaced ~camera !scene

let rotate_left () =
  let camera = get_camera () in
  let forward = Camera.forward camera in
  let forward = V3.to_spherical forward in
  let forward = V3.(v (x forward) Float.(y forward - 0.1) (z forward)) in
  let forward = V3.of_spherical forward in
  let camera = Camera.replaced ~forward camera in
  scene := Scene.replaced ~camera !scene

let rotate_right () =
  let camera = get_camera () in
  let forward = Camera.forward camera in
  let forward = V3.to_spherical forward in
  let forward = V3.(v (x forward) Float.(y forward + 0.1) (z forward)) in
  let forward = V3.of_spherical forward in
  let camera = Camera.replaced ~forward camera in
  scene := Scene.replaced ~camera !scene

let x_array = Array.init x_def Fun.id

let upscale_image factor image =
  let w = Array.length image and h = Array.length image.(0) in
  let w' = factor * w and h' = factor * h in
  Array.init_matrix w' h' (fun x y -> image.(x / factor).(y / factor))

let draw_scene () =
  let scene = !scene in
  Array.make_matrix x_def y_def 0
  |> Parmap.array_parmapi (fun y xs ->
         xs
         |> Array.mapi (fun x _ ->
                let x = x_def - x in
                Scene.get_color scene x y |> Color.to_int ) )
  |> upscale_image upscaling |> Graphics.make_image
  |> fun i -> Graphics.draw_image i 0 0

let () =
  while true do
    draw_scene () ;
    let s = wait_next_event [Key_pressed] in
    if s.key = 'w' || s.key = 'z' then move_forward () ;
    if s.key = 's' then move_backward () ;
    if s.key = 'a' || s.key = 'q' then move_left () ;
    if s.key = 'd' then move_right () ;
    if s.key = 'i' then move_up () ;
    if s.key = 'k' then move_down () ;
    if s.key = 'j' then rotate_left () ;
    if s.key = 'l' then rotate_right ()
  done ;
  exit 0
