open Gg
open Geometry
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
  and ns = Object.normal_surface obj p
  and ray_dir = Ray.direction ray in
  let color_a = Illumination.ambient ambient ka
  and f_color_d light =
    let kd = (Object.material obj).kd
    and id = Light.intensity_diffuse light p in
    Illumination.diffuse kd id ns ray_dir
  and f_color_s light =
    let ks = (Object.material obj).ks
    and is = Light.intensity_specular light p
    and shiness = Light.shiness light
    and dir_light = V3.(Light.position light - p) in
    Illumination.specular ks is shiness ns ray_dir dir_light
  and lights = Illumination.lights_contribute lights objects p in
  lights
  |> Array.fold_left
       (fun acc light -> V4.(acc + f_color_d light + f_color_s light))
       color_a

let get_color scene =
  let {ambient; objects; _} = scene and ray_trace = ray scene in
  fun x y ->
    let ray = ray_trace x y in
    match Objects.nearest_intersection objects ray with
    | None ->
        ambient
    | Some (p, obj) ->
        illumination scene obj p ray
