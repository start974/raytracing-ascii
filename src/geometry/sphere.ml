open Gg
open Aux

let square x = x *. x

type t = {center: v3; radius: float}

let center v = v.center

let radius v = v.radius

let v center radius = {center; radius}
(*
let intersection_with_ray sphere ray =
  let {center= _; radius} = sphere and ray.{origin; direction} = ray in
  (*
   * p in ray <=> p = o + 'l * d
   * p in sphere <=> | p | = r
   * p in sphere <=> | p |^2 = r^2
   * p in ray /\ sphere <=> (p = o + 'l * d) /\ (| p |^2 = r^2)
   * <=> p.x = o.x + 'ld.x
   *  /\ p.y = o.y + 'ld.y
   *  /\ p.z = o.z + 'ld.z
   *  /\ p.x^2 + p.y^2 + p.z^2 = r^2
   * Now we inject the first two rays into the second and try to solve for 'l :
   * (o.x + 'ld.x)^2 + (o.y + 'ld.y)^2 + (o.z + 'ld.z)^2 = r^2
   * <=>   o.x^2 + 2o.x'ld.x + ('ld.x)^2
   *     + o.y^2 + 2o.y'ld.y + ('ld.y)^2
   *     + o.z^2 + 2o.z'ld.z + ('ld.z)^2
   *     = r^2
   * <=>    'l^2 (d.x^2 + d.y^2 + d.z^2)
   *      + 'l   (2o.xd.x + 2o.yd.y + 2o.zd.z)
   *      +      (o.x^2 + o.y^2 + o.z^2 - r^2)
   *      = 0
   *)
  let a =
    V3.(
      IFloat.(
        square (x direction) + square (y direction) + square (z direction)))
  in
  let b =
    V3.(
      IFloat.(
        (2. * x origin * x direction)
        + (2. * y origin * y direction)
        + (2. * z origin * z direction)))
  in
  let c =
    V3.(
      IFloat.(
        square (x origin)
        + square (y origin)
        + square (z origin)
        - (2. * square radius)))
  in
  let delta = IFloat.(square b - (4. * a * c)) in
  if delta < 0. then None
  else
    Some
      (let lambda1 = IFloat.((0. - b + sqrt delta) / (2. * a))
       and lambda2 = IFloat.((0. - b - sqrt delta) / (2. * a)) in
       let lambda1 = Float.fmin lambda1 lambda2
       and lambda2 = Float.fmax lambda1 lambda2 in
       let p1 = ray.apply ray lambda1 and p2 = ray.apply ray lambda2 in
       (p1, p2) ) *)

(*
b = 2 * np.dot(ray_direction, ray_origin - center)
    c = np.linalg.norm(ray_origin - center) ** 2 - radius ** 2
    delta = b ** 2 - 4 * c
    if delta > 0:
        t1 = (-b + np.sqrt(delta)) / 2
        t2 = (-b - np.sqrt(delta)) / 2
        if t1 > 0 and t2 > 0:
            return min(t1, t2)
*)

let intersection_with_ray sphere ray =
  let {center; radius} = sphere
  and origin = Ray.origin ray
  and direction = Ray.direction ray in
  let b = Float.(2. * V3.(dot direction (origin - center)))
  and c = Float.(V3.(norm2 (origin - center)) - square radius) in
  let delta = Float.(square b - (4. * c)) in
  if delta > 0. then
    let t1 = Float.((-.b + sqrt delta) / 2.)
    and t2 = Float.((-.b - sqrt delta) / 2.) in
    if t1 > 0. && t2 > 0. then
      let t = Float.fmin t1 t2 in
      Some (Ray.apply ray t)
    else None
  else None

let is_close_v3 v1 v2 =
  V3.(
    Float.is_close (x v1) (x v2)
    && Float.is_close (y v1) (y v2)
    && Float.is_close (z v1) (z v2))

let%test "sphere intersection 1" =
  let sphere = v V3.zero 1. in
  let ray = Ray.v (V3.v (-2.) 0. 0.) (V3.v 1. 0. 0.) in
  match intersection_with_ray sphere ray with
  | None ->
      false
  | Some p ->
      let ep = V3.v (-1.) 0. 0. in
      is_close_v3 ep p
