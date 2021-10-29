type t

val make : int -> int -> float -> t
(** [make] screen with [width], [height], [aspect_ratio]*)

val width : t -> int
(** [width] of screen*)

val height : t -> int
(** [height] of screen*)

val max_width : t -> float
(** [max width] of screen (with - 1)*)

val max_height : t -> float
(** [max height] of screen (height - 1)*)

val size : t -> int * int
(** [width, height]*)

val aspect_ratio : t -> float
(** [aspect_ratio] ratio beteween [width and height]*)
