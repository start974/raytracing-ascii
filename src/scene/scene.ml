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
  lights |> Array.filter illuminate |> Array.map Light.color
  |> Array.fold_left V4.add ambiant

let get_color scene =
  let {ambiant; objects; _} = scene and ray_trace = ray scene in
  fun x y ->
    let opt_obj = Objects.nearest_intersection objects (ray_trace x y) in
    match opt_obj with
    | None ->
        ambiant
    | Some (p, obj) ->
        let p' = Object.shift_point obj p in
        let illumination_color = illumination scene p' in
        V4.(mul (Object.absorbtion obj) illumination_color)
