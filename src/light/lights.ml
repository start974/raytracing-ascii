open Aux

type t = {ambiant: Ambiant.t; mutable light_points: Point.t list}

let make ambiant = {ambiant; light_points= []}

let add_point lights point_light =
  let {light_points; _} = lights in
  lights.light_points <- point_light :: light_points

let ambiant {ambiant; _} = ambiant

let ambiant_color {ambiant; _} = Ambiant.color ambiant

let nearest_light {ambiant; light_points} point =
  List.fold_left
    (fun candidate lightPoint ->
      let distance, _ = candidate in
      let distance_point = Point.distance2 lightPoint point in
      if distance < distance_point then (distance_point, Point.color lightPoint)
      else candidate )
    (Float.infinity, Ambiant.color ambiant)
    light_points
