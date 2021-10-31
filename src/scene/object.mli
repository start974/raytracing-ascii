open Geometry
open Gg

type obj = Sphere.t

type material = {ka: Color.t; kd: Color.t; ks: Color.t}

type t

val make : obj -> material -> t
(*[make, object, diffuse, specular] and object with associate color absobtion *)

val material : t -> material

val intersection : t -> Ray.t -> P3.t option
(**[intersection] between ray and point *)

val normal_surface : t -> P3.t -> V3.t
(** [normal] of suface at point p*)

val shift_point : ?eps:float -> t -> P3.t -> P3.t
