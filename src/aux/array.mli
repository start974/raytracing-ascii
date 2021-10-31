include module type of Stdlib.Array

val init_matrix : int -> int -> (int -> int -> 'a) -> 'a t t
(** init matrix *)

val min : 'a t -> ('a -> 'b) -> 'a -> 'a

val filter : ('a -> bool) -> 'a t -> 'a t