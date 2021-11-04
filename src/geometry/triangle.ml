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
  let dir_ray = V3.unit @@ Ray.direction ray in
  let n_dot_r = V3.dot n dir_ray in
  if Float.is_close n_dot_r 0. then None
  else
    let o_r = Ray.origin ray and o_t, _, _ = triangle in
    let o_tr = V3.(unit (o_r - o_t)) in
    let i_r =
      let n_dot_otr = V3.dot n o_tr in
      Float.(-.n_dot_otr / n_dot_r)
    in
    if i_r < 0. || i_r > 1. then None
    else
      let q =
        let u_vec = V3.(unit (v_edge1 triangle)) in
        V3.(unit (cross u_vec o_tr))
      in
      let i_u =
        let q_dot_r = V3.dot q dir_ray in
        Float.(q_dot_r / n_dot_r)
      in
      if Float.(i_u < 0. || i_r + i_u > 1.) then None
      else
        let i_v =
          let v_vec = V3.(unit (v_edge2 triangle)) in
          let v_dot_q = V3.dot v_vec q in
          Float.(v_dot_q / n_dot_r)
        in
        if i_v > 0. && not (Float.is_close i_v 0.) then
          Some V3.(o_r + (i_v * dir_ray))
        else None

let%test "triangle intersection" =
  let triangle =
    v P3.(v (-20.) 20. 10.) V3.(v 0. (-10.) 10.) V3.(v 20. 20. 10.)
  in
  let ray = Ray.v P3.(v 0. 0. 0.) V3.(v 0. 0. 1.) in
  let p = Option.get @@ intersection triangle ray in
  print_endline @@ V3.to_string p ;
  V3.is_close p @@ P3.v 0. 0. 10.