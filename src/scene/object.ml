open Geometry
open Aux

type geometry = Sphere.t

type material = {ka: Color.t; kd: Color.t; ks: Color.t; reflexivity: float}

type t = {geometry: geometry; material: material}

let make geometry material = {geometry; material}

let material {material; _} = material

let normal_surface {geometry; _} p = V3.(unit (p - Sphere.center geometry))

let shift_point ?(eps = 0.00001) object_scene p =
  V3.(p + (eps * normal_surface object_scene p))

let intersection {geometry; _} ray = Sphere.intersection_with_ray geometry ray

let reflexion obj ray = Option.get @@ Sphere.reflexion obj.geometry ray
