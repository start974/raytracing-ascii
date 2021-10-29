open Geometry
open Aux
module Camera = Camera
module Screen = Screen
module Lights = Lights
module Objects = Objects

type t =
  {camera: Camera.t; screen: Screen.t; lights: Lights.t; objects: Objects.t}

let make camera screen lights objects = {camera; screen; lights; objects}

let camera {camera; _} = camera

let screen {screen; _} = screen

let lights {lights; _} = lights

let objects {objects; _} = objects

let point {screen; camera; _} =
  let middle_screen = Camera.middle_screen camera
  and ratio = Screen.aspect_ratio screen in
  let half_width = Float.((of_int @@ Screen.width screen) * ratio / 2.)
  and half_height = Float.((of_int @@ Screen.height screen) * ratio / 2.) in
  let p0 =
    V3.(
      v
        Float.(x middle_screen - half_width)
        Float.(y middle_screen + half_height)
        (z middle_screen))
  in
  fun px py ->
    V3.(p0 + v Float.(of_int px * ratio) Float.(of_int py * ratio) 0.)

let ray scene =
  let {camera; _} = scene in
  let origin = Camera.position camera and point = point scene in
  fun x y ->
    let point_screen = point x y in
    Ray.v origin V3.(point_screen - origin)

let get_color scene x y =
  let {lights; objects; _} = scene and ray = ray scene x y in
  let opt_obj = Objects.nearest_intersection objects ray in
  match opt_obj with
  | None ->
      Lights.AmbiantLight.get_color @@ Lights.get_ambiant lights
  | Some (_, obj) ->
      Objects.ObjectScene.get_color obj

let screen_size {screen; _} = Screen.size screen
