open Gg

type t

val v : v3 -> float -> t
(** [v c r] returns a sphere with center [c] and radius [r] *)

val center : t -> v3

val radius : t -> float

val intersection_with_ray : t -> Ray.t -> v3 option
(** [intersection_with_ray s r] return the first intersection with the outside
    of sphere [s] with the ray [r]. If there is none, returns [None].
    The origin of [r] needs to be outside of the sphere. *)

val reflexion : t -> Ray.t -> Ray.t option