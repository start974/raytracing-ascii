open Gg

type t = {position: p3; forward_vec: V3.t}

let make position forward_vec = {position; forward_vec}

let get_position {position; _} = position

let get_forward {forward_vec; _} = forward_vec

let middle_screen camera = V3.(get_position camera + get_forward camera)
