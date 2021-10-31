open Gg
open Geometry

type t = Object.t array

val nearest_intersection : t -> Ray.t -> (p3 * Object.t) Option.t
(*[nearest intersection] between objects and [ray] return intersection point and object
  if found intersection*)
