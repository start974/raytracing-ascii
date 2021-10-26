open Gg

type t

val v : v3 -> v3 -> t

val origin : t -> v3

val direction : t -> v3

val abstract_distance_from_point : (v3 -> 'a) -> t -> v3 -> 'a

val apply : t -> float -> v3

val distance_from_point : t -> v3 -> float

val distance_from_point2 : t -> v3 -> float
