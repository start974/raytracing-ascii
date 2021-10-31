open Aux
open Geometry

type t = Object.t List.t

let make obj_list = obj_list

let nearest_intersection objects ray =
  let distance = function None -> Float.infinity | Some (d, _, _) -> d in
  let intersections =
    objects
    |> List.map (fun o ->
           Object.intersection o ray
           |> Option.map (fun p -> (V3.(norm2 (Ray.origin ray - p)), p, o)) )
  in
  List.min intersections distance None |> Option.map (fun (_, p, o) -> (p, o))
