
open Geometry
open Gg
type obj = Sphere.t

type t = {obj: obj; absorbtion: color}

let make obj absorbtion = {obj; absorbtion}

let absorbtion {absorbtion; _} = absorbtion

let intersection {obj; _} ray = Sphere.intersection_with_ray obj ray
