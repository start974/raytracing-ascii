open Gg

(** [make, diffuse, specular, position, shiness] *)
type t = {position: P3.t; diffuse: Color.t; specular: Color.t; shiness: float}

val position : t -> P3.t

val shiness : t -> float

val distance : t -> P3.t -> float
(*[distance] distance between point and light*)

val distance2 : t -> P3.t -> float
(*[distance] distance^2 between point and light*)

val intensity_diffuse : t -> P3.t -> Color.t

val intensity_specular : t -> P3.t -> Color.t
