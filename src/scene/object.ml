open Geometry
open Aux

type obj = Sphere.t

type material = {ka: Color.t; kd: Color.t; ks: Color.t}

type t = {obj: obj; material: material}

let make obj material = {obj; material}

let material {material; _} = material

let normal_surface {obj; _} p = V3.(unit (p - Sphere.center obj))

let shift_point ?(eps = 0.01) object_scene p =
  V3.(p + (eps * normal_surface object_scene p))

let intersection {obj; _} ray = Sphere.intersection_with_ray obj ray
