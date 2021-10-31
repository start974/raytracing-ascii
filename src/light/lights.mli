open Gg

type t

val make : Ambiant.t -> t
(* [make] lights structure*)

val add_point : t -> Point.t -> unit
(** [add_point light] in structure *)

val ambiant : t -> Ambiant.t

val ambiant_color : t -> Color.t

val nearest_light : t -> P3.t -> float * Color.t
(** [nearest_light] get nearest light with point*)
