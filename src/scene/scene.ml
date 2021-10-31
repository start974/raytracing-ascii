open Gg
open Geometry
open Aux
module Camera = Camera
module Screen = Screen
module Objects = Objects
module Object = Object
module Light = Light

type t =
  {camera: Camera.t; ambiant: Color.t; lights: Light.t array; objects: Objects.t}

let make camera ambiant lights objects = {camera; ambiant; lights; objects}

let ray scene =
  let ray = Camera.ray scene.camera in
  fun x y -> ray x y

let illumination {lights; objects; ambiant; _} obj p ray =
  let ns = Object.normal_surface obj p and ray_dir = Ray.direction ray in
  let color_a =
    let ka = (Object.material obj).ka in
    Illumination.ambient ka ambiant
  and f_color_d light =
    let kd = (Object.material obj).kd
    and id = Light.intensity_diffuse light p in
    Illumination.diffuse kd id ns ray_dir ;
    Color.white
  and f_color_s light =
    let ks = (Object.material obj).ks
    and is = Light.intensity_specular light p
    and shiness = Light.shiness light
    and dir_light = V3.(Light.position light - p) in
    Illumination.specular ks is shiness ns ray_dir dir_light ;
    Color.white
  in
  let f_color light = V4.(f_color_d light + f_color_s light)
  and lights = Illumination.lights_contribute lights objects p in
  lights |> Array.map f_color |> Array.fold_left V4.add color_a

let get_color scene =
  let {objects; ambiant; _} = scene and ray_trace = ray scene in
  fun x y ->
    let ray = ray_trace x y in
    match Objects.nearest_intersection objects ray with
    | None ->
        ambiant
    | Some (p, obj) ->
        illumination scene obj p ray
