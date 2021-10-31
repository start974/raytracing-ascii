open Gg

type t

val make : Color.t -> Color.t -> P3.t -> t
(** [make, diffuse, specular, position] *)

val position : t -> P3.t

val diffuse : t -> Color.t

val distance : t -> P3.t -> float
(*[distance] distance between point and light*)

val distance2 : t -> P3.t -> float
(*[distance] distance^2 between point and light*)

val intensity_diffuse : t -> P3.t -> Color.t

val intensity_specular : t -> P3.t -> Color.t
