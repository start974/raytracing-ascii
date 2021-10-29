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

let nearest_intersection objects ray =
  let distance = function None -> Float.infinity | Some (d, _, _) -> d in
  let intersections =
    objects
    |> List.map (fun o ->
           ObjectScene.intersection o ray
           |> Option.map (fun p -> (Ray.distance_from_point2 ray p, p, o)) )
  in
  List.min intersections distance None |> Option.map (fun (_, p, o) -> (p, o))