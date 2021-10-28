type t

val make : int -> int -> float -> t
(** [make] screen with [width], [height], [aspect_ratio]*)

val get_width : t -> int
(** [weight] of screen*)

val get_height : t -> int
(** [height] of screen*)

val get_aspect_ratio : t -> float
(** to set aspect ratio *)