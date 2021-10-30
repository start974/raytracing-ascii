open Gg

type t

val make : int -> int -> float -> t
(** [make w h r] is the screen with width [w], height [h], and aspect_ratio [r].*)

val width : t -> int
(** [width s] is the width of screen [s], in pixels. *)

val height : t -> int
(** [height s] is the height of screen [s], in pixels. *)

val width_3d : t -> float
(** [width_3d s] is the width of screen [s], in the scene. *)

val height_3d : t -> float
(** [height_3d s] is the height of screen [s], in the scene. *)

val pixel_3d : t -> float

val size : t -> int * int
(** [size s] is [(width s, height s).]*)

val size_3d : t -> V2.t
(** [size_3d s] is [(width_3d s, height_3d s).]*)
