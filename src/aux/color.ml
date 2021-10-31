open Gg
include Color

let int_triple color =
  let to_int x = int_of_float (x *. 255.) in
  Color.(to_int (r color), to_int (g color), to_int (b color))
