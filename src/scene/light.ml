open Gg
open Aux

type t = {diffuse: Color.t; specular: Color.t; position: P3.t}

let make diffuse specular position = {diffuse; specular; position}

let position {position; _} = position

let diffuse {diffuse; _} = diffuse

let distance2 {position; _} point = V3.(norm2 (position - point))

let distance point_light point = Float.(sqrt @@ distance2 point_light point)

let intensity light color p =
  let _k = Float.(1. / distance2 light p) in
  (* FIXME *)
  V4.(1. * color)

let intensity_diffuse light p = intensity light light.diffuse p

let intensity_specular light p = intensity light light.specular p
