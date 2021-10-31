open Gg
open Geometry

type t

val make : Object.t List.t -> t
(* [make] objects collections *)

val nearest_intersection : t -> Ray.t -> (p3 * Object.t) Option.t
(*[nearest intersection] between objects and [ray] return intersection point and object
  if found intersection*)
