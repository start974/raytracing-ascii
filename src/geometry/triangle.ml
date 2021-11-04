open Gg
open Aux

type t = p3 * p3 * p3

let v p0 p1 p2 = (p0, p1, p2)

let v_edge1 (p0, p1, _) = V3.(p1 - p0)

let v_edge2 (p0, _, p2) = V3.(p2 - p0)

let normal triangle = V3.(unit (cross (v_edge1 triangle) (v_edge2 triangle)))

let intersection triangle ray =
  (* Möller–Trumbore algorithme *)
  let n = normal triangle in
  let dir_ray = Ray.direction ray in
  let n_dot_r = V3.dot n dir_ray in
  if Float.is_close n_dot_r 0. then None
  else
    let edge_1 = v_edge1 triangle
    and edge_2 = v_edge2 triangle
    and p0, _, _ = triangle
    and pt = Ray.origin ray in
    let p_vec = V3.cross dir_ray edge_2 in
    let det = V3.dot edge_1 p_vec in
    if Float.is_close (Float.abs det) 0. then None
    else
      let t_vec = V3.(pt - p0) in
      let u = Float.(V3.dot t_vec p_vec / det) in
      if u < 0. || u > 1. then None
      else
        let q_vec = V3.cross t_vec edge_1 in
        let v = Float.(V3.dot dir_ray q_vec / det) in
        if Float.(v < 0. || u + v > 1.) then None
        else
          let t = Float.(V3.dot edge_2 q_vec / det) in
          Some V3.(pt + (t * dir_ray))

let%test "triangle intersection" =
  let triangle =
    v P3.(v (-20.) 20. 10.) V3.(v 0. (-10.) 10.) V3.(v 20. 20. 10.)
  in
  let ray = Ray.v P3.(v 0. 0. 0.) V3.(v 0. 0. 1.) in
  let p = Option.get @@ intersection triangle ray in
  V3.is_close p @@ P3.v 0. 0. 10.