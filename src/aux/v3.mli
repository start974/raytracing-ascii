include module type of Gg.V3

val is_close : t -> t -> bool

val is_orthogonal : t -> t -> bool

val to_triple_int : t -> int * int * int

val to_string : t -> string

val is_colinear : t -> t -> bool

val one : t
