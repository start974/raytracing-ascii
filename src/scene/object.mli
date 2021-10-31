open Geometry
open Gg

type geometry = Sphere.t

type t

val make : geometry -> Color.t -> float -> t
(** [make g a r] is the object with geometry [g], absorbtion [a] and reflexivity
    [r]. *)

val absorbtion : t -> Color.t

val reflexivity : t -> float

val reflexion : t -> Ray.t -> Ray.t

val intersection : t -> Ray.t -> P3.t option

val shift_point : ?eps:float -> t -> P3.t -> P3.t
