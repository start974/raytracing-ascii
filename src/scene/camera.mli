open Gg
open Aux

type t

val make : p3 -> V3.t -> t
(** [make] camera with [position], [forward vector] *)

val position : t -> p3
(**[position] position of camera *)

val forward : t -> V3.t
(** vector to positionate screen *)

val middle_screen : t -> p3
(** [middle] middle of the screen *)