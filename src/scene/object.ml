open Geometry
open Aux

type geometry = Sphere.t

type t = {geometry: geometry; absorbtion: Color.t; reflexivity: float}

let make geometry absorbtion reflexivity = {geometry; absorbtion; reflexivity}

let absorbtion {absorbtion; _} = absorbtion

let reflexivity {reflexivity; _} = reflexivity

let shift_point ?(eps = 0.00001) {geometry; _} p =
  let normal = V3.(unit (p - Sphere.center geometry)) in
  V3.(p + (eps * normal))

let intersection {geometry; _} ray = Sphere.intersection_with_ray geometry ray

let reflexion obj ray = Option.get @@ Sphere.reflexion obj.geometry ray
