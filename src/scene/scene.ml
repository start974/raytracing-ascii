open Gg
open Aux
open Geometry
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

let illumination {ambiant; lights; objects; _} p =
  let illuminate light =
    not
    @@ Array.exists
         (fun obj ->
           let ray = Ray.v p V3.(Light.position light - p) in
           Option.is_some @@ Object.intersection obj ray )
         objects
  in
  lights |> Array.filter illuminate
  |> Array.map (fun light -> V4.(Light.color light / Light.distance2 light p))
  |> Array.fold_left V4.add ambiant

let rec get_color_of_ray ?(max_iteration = 10) scene ray =
  let {objects; ambiant; _} = scene in
  if max_iteration = 0 then ambiant
  else
    let opt_obj = Objects.nearest_intersection objects ray in
    match opt_obj with
    | None ->
        ambiant
    | Some (p, obj) ->
        let p' = Object.shift_point obj p in
        let illumination_color = illumination scene p' in
        let reflexivity = Object.reflexivity obj in
        let incoming =
          if Float.is_close reflexivity 0. then V4.zero
          else
            let max_iteration = max_iteration - 1 in
            let reflexion = Object.reflexion obj ray in
            get_color_of_ray ~max_iteration scene reflexion
        in
        V4.(mul (Object.absorbtion obj) (illumination_color + incoming))

let get_color scene =
  let ray_trace = ray scene and get_color_of_ray = get_color_of_ray scene in
  fun x y -> get_color_of_ray (ray_trace x y)
