open Gg

type t = {position: p3; forward_vec: V3.t}

let make position forward_vec = {position; forward_vec}

let position {position; _} = position

let forward {forward_vec; _} = forward_vec

let middle_screen camera = V3.(position camera + forward camera)
