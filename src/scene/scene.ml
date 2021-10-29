open Geometry
module Camera = Camera
module Screen = Screen
module Lights = Lights
module Objects = Objects

type t =
  {camera: Camera.t; screen: Screen.t; lights: Lights.t; objects: Objects.t}

let make camera screen lights objects = {camera; screen; lights; objects}

let get_camera {camera; _} = camera

let get_screen {screen; _} = screen

let get_lights {lights; _} = lights

let get_objects {objects; _} = objects

let iter_pos {screen; camera; _} f = Screen.iter screen camera f

let iter_ray scene f =
  let cam_pos = Camera.get_position @@ get_camera scene in
  let get_ray pos_pix = Ray.v cam_pos pos_pix in
  iter_pos scene (fun pos -> f @@ get_ray pos)

let compute_color {lights; objects; _} ray =
  match Objects.nearest_intersection objects ray with None -> (0, 0, 0)
(*TODO *)
