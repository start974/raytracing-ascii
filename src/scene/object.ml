open Geometry
open Aux

type obj = Sphere.t

type t = {obj: obj; absorbtion: Color.t}

let make obj absorbtion = {obj; absorbtion}

let absorbtion {absorbtion; _} = absorbtion

let shift_point ?(eps = 0.00001) {obj; _} p =
  let normal = V3.(unit (p - Sphere.center obj)) in
  V3.(p + (eps * normal))

let intersection {obj; _} ray = Sphere.intersection_with_ray obj ray
