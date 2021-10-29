open Gg
include V3

let is_close v1 v2 =
  IFloat.is_close (x v1) (x v2)
  && IFloat.is_close (y v1) (y v2)
  && IFloat.is_close (z v1) (z v2)

let is_colinear v1 v2 =
  is_close (unit v1) (unit v2) || is_close (smul (-1.) (unit v1)) (unit v2)
