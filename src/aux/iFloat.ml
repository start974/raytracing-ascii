include Stdlib.Float
include Gg.Float

let ( + ) = add

let ( * ) = mul

let ( / ) = div

let ( - ) = sub

let ( -~ ) = sub 0.

let is_close ?(eps = 0.00001) x y = is_zero ~eps (x - y)

let%test "is close 1" = is_close 1. 1.

let%test "is close 2" = is_close 1. 1.000001

let%test "is close 3" = not @@ is_close 1. 2.
