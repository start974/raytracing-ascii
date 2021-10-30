type t

val make : int -> int -> float -> t
(** [make w h r] is the screen with width [w], height [h], and aspect_ratio [r].*)

val width : t -> int
(** [width s] is the width of screen [s] *)

val height : t -> int
(** [height s] is the height of screen [s] *)

val max_width : t -> float
(** [max_width] of screen (with - 1)*)

val max_height : t -> float
(** [max height] of screen (height - 1)*)

val size : t -> int * int
(** [width, height]*)

val aspect_ratio : t -> float
(** [aspect_ratio] ratio beteween [width and height]*)
