open Gg
include Color

let int_triple color =
  let to_int x = int_of_float (x *. 255.) |> min 255 |> max 0 in
  Color.(to_int (r color), to_int (g color), to_int (b color))

let to_string color =
  let int_r, int_g, int_b = int_triple color in
  Printf.sprintf "rgb: %d, %d, %d (%f %f %f %f)" int_r int_g int_b (r color)
    (g color) (b color) (a color)
