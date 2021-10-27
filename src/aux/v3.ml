open Gg
include V3

let is_close v1 v2 =
  IFloat.is_close (x v1) (x v2)
  && IFloat.is_close (y v1) (y v2)
  && IFloat.is_close (z v1) (z v2)
