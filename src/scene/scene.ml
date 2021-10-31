open Gg
open Aux
module Camera = Camera
module Screen = Screen
module Objects = Objects
module Object = Object
module Light = Light

type t =
  {camera: Camera.t; ambient: Color.t; lights: Light.t array; objects: Objects.t}

let make camera ambient lights objects = {camera; ambient; lights; objects}

let ray scene =
  let ray = Camera.ray scene.camera in
  fun x y -> ray x y

let illumination {ambient; lights; objects; _} obj p ray =
  let ka = (Object.material obj).ka
  and kd = (Object.material obj).kd
  and ns = Object.normal_surface obj p
  and lights = Illumination.lights_contribute lights objects p in
  let color_a = Illumination.ambient ambient ka in
  let color_d =
    Array.map
      (fun l ->
        let id = Light.intensity_diffuse l p in
        Illumination.diffuse kd id ns ray )
      lights
  in
  color_d |> Array.fold_left V4.add color_a

let get_color scene =
  let {ambient; objects; _} = scene and ray_trace = ray scene in
  fun x y ->
    let ray = ray_trace x y in
    match Objects.nearest_intersection objects ray with
    | None ->
        ambient
    | Some (p, obj) ->
        illumination scene obj p ray
