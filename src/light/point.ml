open Gg
open Aux

type t = {color: Color.t; position: P3.t}

let make color position = {color; position}

let color {color; _} = color

let position {position; _} = position

let distance2 {position; _} point = V3.(norm2 (position - point))

let distance point_light point = Float.(sqrt @@ distance2 point_light point)
