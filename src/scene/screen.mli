open Gg

type t

val make : int -> int -> float -> t
(** [make] screen with [width], [height], [aspect_ratio]*)

val get_width : t -> int
(** [weight] of screen*)

val get_height : t -> int
(** [height] of screen*)

val get_aspect_ratio : t -> float
(** to set aspect ratio *)

val iter : t -> Camera.t -> (p3 -> unit) -> unit
(** [iterate] on all position of screen
    send [pos3] to a function to iterate*)