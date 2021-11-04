include Stdlib.Float
include Gg.Float

let ( + ) = add

let ( * ) = mul

let ( / ) = div

let ( - ) = sub

let ( -~ ) = sub 0.

let to_rad degree = degree * pi / 180.

let to_deg rad = rad * 180. / pi

let is_close ?(eps = 0.00001) x y = is_zero ~eps (x - y)

let square x = x *. x

let ( mod ) = mod_float

let normalize_angle angle = ((angle mod pi) + pi) mod pi

let%test "normalize_angle 1" = is_close (normalize_angle pi_div_2) pi_div_2

let%test "normalize_angle 2" = is_close (normalize_angle (-.pi_div_2)) pi_div_2

let%test "normalize_angle 3" =
  is_close (normalize_angle (pi + pi_div_2)) pi_div_2

let%test "is close 1" = is_close 1. 1.

let%test "is close 2" = is_close 1. 1.000001

let%test "is close 3" = not @@ is_close 1. 2.
