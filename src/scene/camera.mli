open Gg
open Aux

type t

val make : p3 -> V3.t -> t
(** [make] camera with [position], [forward vector] *)

val get_position : t -> p3
(**[get_position] position of camera *)

val get_forward : t -> V3.t
(** vector to positionate screen *)
