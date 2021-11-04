open Gg

type t

val v : v3 -> v3 -> t
(**[v orgin direction]*)

val origin : t -> v3

val direction : t -> v3

val apply : t -> float -> v3
(** [apply r l] is the point of ray [r] at distance [l] from [origin r]. *)

val distance_from_point : t -> v3 -> float

val distance_from_point2 : t -> v3 -> float

val to_string : t -> string
