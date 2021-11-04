open Gg
include Color

let int_triple color =
  let r, g, b, _ = color |> clamp |> to_srgbi in
  (r, g, b)

let to_gray color =
  let r, g, b, _ = color |> clamp |> V4.to_tuple in
  IFloat.((r + g + b) / 3.)

let to_string color =
  let i_r, i_g, i_b = int_triple color in
  let f_r, f_g, f_b, f_a = V4.to_tuple color in
  Printf.sprintf "rgb: %d, %d, %d (%f %f %f %f)" i_r i_g i_b f_r f_g f_b f_a

let to_int c =
  let r, g, b = int_triple c in
  (r * 256 * 256) + (g * 256) + b
