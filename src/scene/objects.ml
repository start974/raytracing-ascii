open Aux
open Geometry

module ObjectScene = struct
  type obj = Sphere.t

  type color = V3.t (* TODO go to color but mult not work*)

  type t = {obj: obj; color: color}

  let make obj color = {obj; color}

  let get_color {color; _} = color

  let intersection {obj; _} ray =
    print_endline (V3.to_string (Ray.origin ray)) ;
    print_endline (V3.to_string (Ray.direction ray)) ;
    let res = Sphere.intersection_with_ray obj ray in
    ( match res with
    | None ->
        print_endline "Nop"
    | Some _ ->
        print_endline "intersecion" ) ;
    print_endline "----" ; res
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