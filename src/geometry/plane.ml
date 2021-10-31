open Gg
open Aux

type t = {origin: V3.t; normal: V3.t}

let v origin normal = {origin; normal= V3.unit normal}

let origin p = p.origin

let normal p = p.normal

let mem {origin; normal} point =
  let point = V3.(point - origin) in
  V3.is_orthogonal point normal

let frame ~up normal =
  assert (not @@ V3.is_colinear normal up) ;
  let fx = V3.cross normal up in
  let fy = V3.cross normal fx in
  V3.(unit fx, unit fy)

let apply {origin; normal} ~up point =
  let frame_x, frame_y = frame ~up normal in
  V3.(origin + (smul (V2.x point) frame_x + smul (V2.y point) frame_y))

let%test "plane mem" =
  let plane = v V3.(v 0. 0. 0.) V3.(v 1. 0. 0.) in
  let mem = mem plane in
  mem V3.(v 0. 1. 0.)
  && mem V3.(v 0. 0. 1.)
  && mem V3.(v 0. 1. 1.)
  && mem V3.(v 0. 1. (-1.5))

let%test "plane not mem" =
  let plane = v V3.(v 0. 0. 0.) V3.(v 1. 0. 0.) in
  let mem = mem plane in
  (not @@ mem V3.(v 1. 1. 0.))
  && (not @@ mem V3.(v 1. 0. 1.))
  && (not @@ mem V3.(v 1. 1. 1.))
  && (not @@ mem V3.(v 1. 1. (-1.5)))

let%test "plane frame 1" =
  let plane = v V3.(v 0. 0. 0.) V3.(v 1. 0. 0.) in
  let up = V3.(v 0. 0. 1.) in
  let normal = normal plane in
  let fx, fy = frame ~up normal in
  V3.is_orthogonal fx fy && mem plane fx && mem plane fy

let%test "plane frame 2" =
  let plane = v V3.(v 0. 0. 0.) V3.(v 0. 1. 0.) in
  let up = V3.(v 0. 0. 1.) in
  let normal = normal plane in
  let fx, fy = frame ~up normal in
  V3.is_orthogonal fx fy && mem plane fx && mem plane fy

let%test "plane frame 2" =
  let plane = v V3.(v 0. 0. 0.) V3.(v 1. 1. 1.) in
  let up = V3.(v 0. 0. 1.) in
  let normal = normal plane in
  let fx, fy = frame ~up normal in
  V3.is_orthogonal fx fy && mem plane fx && mem plane fy
