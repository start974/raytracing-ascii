type t

val make : int -> int -> float -> t
(** [make] screen with [width], [height], [aspect_ratio]*)

val width : t -> int
(** [width] of screen*)

val height : t -> int
(** [height] of screen*)

val size : t -> int * int
(** [width, height]*)

val aspect_ratio : t -> float
(** to set aspect ratio *)
