open Geometry
open Aux

type geometry = Sphere.t


type t = {geometry: geometry; material: material}

let make obj material = {obj; material}

let material {material; _} = material

let normal_surface {obj; _} p = V3.(unit (p - Sphere.center obj))

let shift_point ?(eps = 0.00001) object_scene p =
  V3.(p + (eps * normal_surface object_scene p))

let intersection {geometry; _} ray = Sphere.intersection_with_ray geometry ray

let reflexion obj ray = Option.get @@ Sphere.reflexion obj.geometry ray
