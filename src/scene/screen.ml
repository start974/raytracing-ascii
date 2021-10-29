open Gg

type t = {width: int; height: int; aspect_ratio: float}

let make width height aspect_ratio = {width; height; aspect_ratio}

let get_width {width; _} = width

let get_height {height; _} = height

let get_aspect_ratio {aspect_ratio; _} = aspect_ratio

let get_min_point width height ratio middle =
  let distance_on_2 x = float_of_int x *. ratio /. 2. in
  let min_x = distance_on_2 width and min_y = -1. *. distance_on_2 height in
  V3.(middle - v min_x min_y 0.)

let iter screen camera f =
  let width = get_width screen
  and height = get_height screen
  and ratio = get_aspect_ratio screen in
  let p0 = get_min_point width height ratio @@ Camera.middle_screen camera in
  let rec iterate x y p_i =
    f p_i ;
    if x + 1 >= width then
      iterate 0 (y + 1) P3.(v (x p0) (y p0 -. ratio) (z p_i))
    else if y + 1 < height then iterate (x + 1) y V3.(p_i + v ratio 0. 0.)
  in
  iterate 0 0 p0
