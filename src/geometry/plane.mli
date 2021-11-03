open Gg

type t

val v : p3 -> v3 -> t
(** [make plane] with [point] [normal]*)

val origin : t -> p3
(** [origin] of plane*)

val normal : t -> v3
(** [normal] of plane *)

val intersection : t -> Ray.t -> p3 option
(** [intersection s r] return the intersection with plane with the ray [r]. 
    If there is none, returns [None].*)

val apply : t -> up:v3 -> v2 -> v3
