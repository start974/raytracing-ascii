open Gg
open Aux
open Geometry

type t

val make : p3 -> V3.t -> Screen.t -> t
(** [make p f] is the camera with position [p], and forward vector [f] *)

val replaced : ?position:v3 -> ?forward:v3 -> ?screen:Screen.t -> t -> t

val position : t -> p3
(**[position] position of camera *)

val forward : t -> V3.t
(** vector to positionate screen *)

val middle_screen : t -> p3
(** [middle] middle of the screen *)

val ray : t -> int -> int -> Ray.t

val screen_plane : t-> Plane.t