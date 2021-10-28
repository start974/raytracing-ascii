open Gg

type t = {position: p3; forward_vec: V3.t}

let make position forward_vec = {position; forward_vec}

let get_position camera = camera.position

let get_forward camera = camera.forward_vec
