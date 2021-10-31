open Geometry
open Gg
 type obj = Sphere.t

 type t

 val make : obj -> Color.t -> t
 (*[make] and object with associate color absobtion *)

 val absorbtion : t -> Color.t

 val intersection: t -> Ray.t -> P3.t option