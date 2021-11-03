open Gg

type t

val v : v3 -> float -> t
(** [v c r] returns a sphere with center [c] and radius [r] *)

val center : t -> v3

val radius : t -> float

val intersection : t -> Ray.t -> p3 option
(** [intersection with ray s r] return the first intersection with the outside
    of sphere [s] with the ray [r]. If there is none, returns [None].
    The origin of [r] needs to be outside of the sphere. *)

val normal : t -> P3.t -> V3.t
(**[normal] of sphere at point [p]*)
