open Gg
include V3

let is_close v1 v2 =
  IFloat.is_close (x v1) (x v2)
  && IFloat.is_close (y v1) (y v2)
  && IFloat.is_close (z v1) (z v2)

let to_triple_int v =
  let to_int_coord f = int_of_float @@ f v in
  (to_int_coord x, to_int_coord y, to_int_coord z)