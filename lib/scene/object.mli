open Geometry
open Gg

type geometry =
  | OSphere of Sphere.t
  | OPlane of Plane.t
  | OTriangle of Triangle.t

type material =
  { ka: Color.t
  ; kd: Color.t
  ; ks: Color.t
  ; reflexivity: float
  ; refraction_index: float
  ; opacity: float }

type t

val make : geometry -> material -> t
(**[make, geometry, material] and object with geometry and material *)

val sphere : p3 -> float -> material -> t
(**[make, p, r, material] a sphere at poisition [p] and radius [r]*)

val plane : p3 -> v3 -> material -> t
(**[make, p, n] a plane with normal [n] and one point [p]*)

val triangle : p3 -> p3 -> p3 -> material -> t
(** [make p1, p2, p3] a triangle with 3 point*)

val mesh : Triangle.t array -> material -> t array
(** [make] a mesh with many triangle and apply material *)

val material : t -> material

val reflexion : ?eps:float -> t -> Ray.t -> Ray.t

val refraction : ?eps:float -> t -> float -> Ray.t -> Ray.t
(* [refraction] with [object, relexion env 1 (n1), ray]*)

val intersection : t -> Ray.t -> P3.t option
(**[intersection] between ray and point *)

val normal_surface : t -> P3.t -> V3.t
(** [normal] of suface at point p*)

val shift_point : ?eps:float -> t -> P3.t -> P3.t
