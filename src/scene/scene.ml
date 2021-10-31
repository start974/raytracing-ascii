open Gg
module Camera = Camera
module Screen = Screen
module Lights = Light.Lights
module Objects = Objects
module Object = Object

type t = {camera: Camera.t; lights: Lights.t; objects: Objects.t}

let make camera lights objects = {camera; lights; objects}

let camera {camera; _} = camera

let lights {lights; _} = lights

let objects {objects; _} = objects

let ray scene =
  let ray = Camera.ray scene.camera in
  fun x y -> ray x y

let get_color scene =
  let {lights; objects; _} = scene and ray_trace = ray scene in
  fun x y ->
    let opt_obj = Objects.nearest_intersection objects (ray_trace x y) in
    match opt_obj with
    | None ->
        Lights.ambiant_color lights
    | Some (_p, obj) ->
        V4.(mul (Object.absorbtion obj) (Lights.ambiant_color lights))
