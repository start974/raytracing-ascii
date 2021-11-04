open Gg

type t

val v : p3 -> p3 -> p3 -> t
(** [create triangle] with 3 points*)

val intersection : t -> Ray.t -> p3 option
(** [intersection with ray s r] return intersection with triangle 
    If there is none, returns [None]. *)

val normal : t -> V3.t
(**[normal] of triangle]*)
