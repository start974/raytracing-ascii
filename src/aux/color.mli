include module type of Gg.Color

val int_triple : t -> int * int * int

val to_string : t -> string

val to_gray : t -> float
(**[to_gray, color] make a mean of r,g,b, in float *)