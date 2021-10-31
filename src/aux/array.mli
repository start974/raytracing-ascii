include module type of Stdlib.Array

val init_matrix : int -> int -> (int -> int -> 'a) -> 'a t t
(** init matrix *)
