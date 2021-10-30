open Gg
open Aux

type t = {origin: V3.t; normal: V3.t}

let v origin normal = {origin; normal= V3.unit normal}

let origin p = p.origin

let normal p = p.normal

let mem {origin; normal} point =
  let point = V3.(point - origin) in
  V3.is_orthogonal point normal

let frame normal =
  let snormal = V3.to_spherical normal in
  let fx =
    V3.(of_spherical (v (x snormal) Float.(y snormal + pi_div_4) (z snormal)))
  in
  let fy =
    V3.(of_spherical (v (x snormal) (y snormal) Float.(z snormal + pi_div_4)))
  in
  (fx, fy)

let apply {origin; normal} point =
  let frame_x, frame_y = frame normal in
  V3.(origin + (smul (V2.x point) frame_x + smul (V2.y point) frame_y))