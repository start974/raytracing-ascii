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

let replaced ?camera ?ambiant ?lights ?objects scene =
  { camera= Option.value ~default:scene.camera camera
  ; ambiant= Option.value ~default:scene.ambiant ambiant
  ; lights= Option.value ~default:scene.lights lights
  ; objects= Option.value ~default:scene.objects objects }

let camera scene = scene.camera

let ray scene =
  let ray = Camera.ray scene.camera in
  fun x y -> ray x y

(** TODO change to intesity V4.(Light.color light / Light.distance2 light p)
  lights |> Array.filter illuminate
  |> Array.map )
  |> Array.fold_left V4.add ambiant
  *)
let illumination {lights; objects; ambiant; _} obj p ray =
  let ns = Object.normal_surface obj p and ray_dir = Ray.direction ray in
  let color_a =
    let ka = (Object.material obj).ka in
    Illumination.ambient ka ambiant
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
  in
  let f_color light = V4.(f_color_d light + f_color_s light)
  and lights = Illumination.lights_contribute lights objects p in
  lights |> Array.map f_color |> Array.fold_left V4.add color_a

let rec get_color_of_ray ?(max_iteration = 3) scene ray =
  let {objects; ambiant; _} = scene in
  if max_iteration = 0 then ambiant
  else
    let opt_obj = Objects.nearest_intersection objects ray in
    match opt_obj with
    | None ->
        ambiant
    | Some (p, obj) ->
        let p' = Object.shift_point obj p
        and k_refl = (Object.material obj).reflexivity
        and opacity = (Object.material obj).opacity
        and max_iteration = max_iteration - 1 in
        let illumination_color = V4.(opacity * illumination scene obj p' ray) in
        let reflexive_color =
          if Float.is_close k_refl 0. then V4.zero
          else
            let reflexion = Object.reflexion obj ray in
            V4.(k_refl * get_color_of_ray ~max_iteration scene reflexion)
        in
        let refraction_color =
          if Float.(is_close k_refl 1. || is_close opacity 1.) then V4.zero
          else
            let refraction = Object.refraction obj 1. ray
            and k = Float.((1. - k_refl) * (1. - opacity)) in
            V4.(k * get_color_of_ray ~max_iteration scene refraction)
        in
        V4.(illumination_color + reflexive_color + refraction_color)

let get_color scene =
  let ray_trace = ray scene and get_color_of_ray = get_color_of_ray scene in
  fun x y -> get_color_of_ray (ray_trace x y)
