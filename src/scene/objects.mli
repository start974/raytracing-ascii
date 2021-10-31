open Gg
open Geometry

module ObjectScene : sig
  type obj = Sphere.t

  type color = V3.t

  type t

  val make : obj -> color -> t
  (*[make] and object with associate color *)

  val get_color : t -> color
  (**[get_color] color of the object*)
end

type t

val make : ObjectScene.t List.t -> t
(* [make] objects collections *)

val nearest_intersection : t -> Ray.t -> (p3 * ObjectScene.t) Option.t
(*[nearest intersection] between objects and [ray] return intersection point and object
  if found intersection*)
