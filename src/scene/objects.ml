open Aux
open Geometry

module ObjectScene = struct
  type obj = Sphere.t

  type color = V3.t (* TODO go to color but mult not work*)

  type t = {obj: obj; color: color}

  let make obj color = {obj; color}

  let get_color {color; _} = color

  let intersection {obj; _} ray = Sphere.intersection_with_ray obj ray
end

type t = ObjectScene.t List.t

let make obj_list = obj_list

let min_intersection ray acc obj =
  match ObjectScene.intersection obj ray with
  | None ->
      acc
  | Some p -> (
      let dist = Ray.distance_from_point ray p in
      match acc with
      | None ->
          None
      | Some (d, _, _) ->
          if d < dist then acc else Some (dist, p, obj) )

let nearest_intersection objects ray =
  let extract_result = function
    | None ->
        None
    | Some (_, p, o) ->
        Some (p, o)
  in
  extract_result @@ List.fold_left (min_intersection ray) None objects