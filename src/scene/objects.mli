open Gg
open Geometry

module ObjectScene : sig
  type obj = Sphere.t

  type t

  val make : obj -> color -> t
  (*[make] and object with associate color *)

  val get_color : t -> color
  (**[get_color] color of the object*)
end

type t

val make : ObjectScene.t List.t -> t
(* [make] objects collections *)

(*
  type obj

  val nearest_intersection t -> ray -> option (p3 * obj)
  *)
