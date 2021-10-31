open Gg

type t

val make : Color.t -> P3.t -> t
(** [make] a point light and position *)

val color : t -> Color.t

val position : t -> P3.t

val distance : t -> P3.t -> float
(*[distance] distance between point and light*)

val distance2 : t -> P3.t -> float
(*[distance] distance^2 between point and light*)
