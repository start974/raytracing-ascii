open Gg
open Aux

type t = {origin: V3.t; normal: V3.t}

let v origin normal = {origin; normal= V3.unit normal}

let origin p = p.origin

let normal p = p.normal

let mem {origin; normal} point =
  let point = V3.(point - origin) in
  V3.is_orthogonal point normal

let frame ~up {normal; _} =
  assert (not @@ V3.is_colinear normal up) ;
  let fx = V3.cross normal up in
  let fy = V3.cross normal fx in
  V3.(unit fx, unit fy)

let apply plane ~up point =
  let origin = plane.origin in
  let frame_x, frame_y = frame ~up plane in
  V3.(origin + (smul (V2.x point) frame_x + smul (V2.y point) frame_y))

let intersection ?(keep_inv_dir = false) {normal; origin} ray =
  (*
     vec normal (n)= (a, b, c)
     point origin (O)= (Oa, Ob, Oc)
     ray dir (r) = (u, v, w)
     ray point (A) = (Ax, Ay, Az)

     - if parallele or  n and r in same dir: (n.d <= 0)
     - if intersection: n and d no orthogonal

     plan eq carthé: a x + b y + c z = d
     and d = (a * Oa + b * Ob + c * Oc) = n . O

     droite eq para: (D)
     xd = Ax + t * u
     yd = Ay + t * v
     zd = Az + t * w

     we need to solve:
     d = a (Ax + t0 * u) + b (Ay + t0 * v) + c (Az + t0 * w)
     t0 = (d - a * Ax + b * Ay + c * Az) / (a * u + b * v + c * w)
        = (d - n . A) / (n . r)

     and change t by t0 D eq to get poisition
     p = A + t0 * dir
  *)
  let ray_dir = Ray.direction ray in
  let n_dot_r = V3.(dot normal ray_dir) in
  (*print_endline @@ Float.to_string n_dot_r ;*)
  if ((not keep_inv_dir) && n_dot_r < 0. && n_dot_r <> -1.) || n_dot_r = 0. then
    None
  else
    let d = V3.(dot origin normal) and ray_origin = Ray.origin ray in
    let n_dot_a = V3.dot normal ray_origin in
    let t0 = Float.((d - n_dot_a) / n_dot_r) in
    let p = V3.(ray_origin + (t0 * ray_dir)) in
    Some p

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
  let fx, fy = frame ~up plane in
  V3.is_orthogonal fx fy && mem plane fx && mem plane fy

let%test "plane frame 2" =
  let plane = v V3.(v 0. 0. 0.) V3.(v 0. 1. 0.) in
  let up = V3.(v 0. 0. 1.) in
  let fx, fy = frame ~up plane in
  V3.is_orthogonal fx fy && mem plane fx && mem plane fy

let%test "plane frame 2" =
  let plane = v V3.(v 0. 0. 0.) V3.(v 1. 1. 1.) in
  let up = V3.(v 0. 0. 1.) in
  let fx, fy = frame ~up plane in
  V3.is_orthogonal fx fy && mem plane fx && mem plane fy

let%test "plane no intersection" =
  let plane = v V3.(v 0. 0. 10.) V3.(v 0. 1. 0.) in
  let ray = Ray.v P3.(v 0. 0. 1.) V3.(v 1. 0. 0.) in
  Option.is_none (intersection plane ray)

let%test "plane intersection" =
  let plane = v P3.(v 10. 10. 10.) V3.(v 0. 0. (-1.)) in
  let ray = Ray.v P3.(v 0. 0. 10.) V3.(v 0. 0. 1.) in
  let p = Option.get @@ intersection plane ray in
  V3.is_close p @@ P3.v 0. 0. 10.