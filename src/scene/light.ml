open Gg
open Aux

type t = {position: P3.t; diffuse: Color.t; specular: Color.t; shiness: float}

let position {position; _} = position

let shiness {shiness; _} = shiness

let distance2 {position; _} point = V3.(norm2 (position - point))

let distance point_light point = Float.(sqrt @@ distance2 point_light point)

let intensity light color p =
  let _k = Float.(1. / distance2 light p) in
  (*V4.(1. * color)*)
  color

let intensity_diffuse light p = intensity light light.diffuse p

let intensity_specular light p = intensity light light.specular p
