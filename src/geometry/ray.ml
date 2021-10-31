open Gg
open Aux

type t = {origin: p3; direction: v3}

let v origin direction =
  assert (not @@ Float.is_close (V3.norm2 direction) 0.) ;
  {origin; direction= V3.unit direction}

let origin v = v.origin

let direction v = v.direction

let apply {origin; direction} lambda = V3.(origin + smul lambda direction)

let mem {origin; direction} p =
  let direction' = V3.(p - origin) in
  V3.is_colinear direction direction'

let closest_mem ray point =
  let {origin; direction} = ray in
  let point_vector = V3.(point - origin) in
  let distance_of_projection_from_origin = V3.dot direction point_vector in
  apply ray distance_of_projection_from_origin

let abstract_distance_from_point dist ray point =
  let closest_point = closest_mem ray point in
  V3.(dist (closest_point - point))

let distance_from_point = abstract_distance_from_point V3.norm

let distance_from_point2 = abstract_distance_from_point V3.norm2

let reflexion ray intersection normal =
  let direction = direction ray in
  v intersection
    V3.(direction - smul Float.(2. * V3.dot direction normal) normal)

let to_string {origin; direction} =
  "origin: " ^ V3.to_string origin ^ " | dir: " ^ V3.to_string direction

let%test "reflexion 1" =
  let ray = v (V3.v 0. 0. 0.) (V3.v 1. 0. 0.) in
  let intersection = V3.v 2. 0. 0. in
  let normal = V3.v (-1.) 0. 0. in
  let {origin; direction} = reflexion ray intersection normal in
  let eorigin = intersection in
  let edirection = V3.v (-1.) 0. 0. in
  origin = eorigin && V3.is_close direction edirection

(* let%test "reflexion 2" =
   let ray = v (V3.v 0. 0. 0.) (V3.v 1. 0. 0.) in
   let intersection = V3.v 2. 0. 0. in
   let normal = V3.v (-1.) 1. 0. in
   let {origin; direction} = reflexion ray intersection normal in
   let eorigin = intersection in
   let edirection = V3.v 0. 1. 0. in
   V3.pp Format.std_formatter direction ;
   origin = eorigin && V3.is_close direction edirection *)

let%test "ray distance from point 1" =
  let ray = v V3.zero (V3.v 1. 0. 0.) in
  let point = V3.v 1. 0. 0. in
  let dist = distance_from_point ray point in
  Float.is_close dist 0.

let%test "ray distance from point 2" =
  let ray = v V3.zero (V3.v 1. 0. 0.) in
  let point = V3.v 156. 0. 0. in
  let dist = distance_from_point ray point in
  Float.is_close dist 0.

let%test "ray distance from point 3" =
  let ray = v V3.zero (V3.v 1. 0. 0.) in
  let point = V3.v 0. 1. 0. in
  let dist = distance_from_point ray point in
  Float.is_close dist 1.

let%test "ray mem" =
  let ray1 = v V3.zero (V3.v 1. 2. 3.)
  and p1 = V3.(smul 1.234 @@ v 1. 2. 3.)
  and ray2 = v V3.zero (V3.v 2. 100.4 3.)
  and p2 = V3.(smul 14.234 @@ v 2. 100.4 3.)
  and ray3 = v (V3.v 1. 0. 3.) (V3.v 2. 100.4 3.)
  and p3 = V3.(V3.v 1. 0. 3. + (smul 14.234 @@ v 2. 100.4 3.)) in
  mem ray1 p1 && mem ray2 p2 && mem ray3 p3

let%test "ray not mem" =
  let ray1 = v V3.zero (V3.v 1. 3. 3.)
  and p1 = V3.(smul 1.234 @@ v 1. 2. 3.)
  and ray2 = v V3.zero (V3.v 2. 10.4 3.)
  and p2 = V3.(smul 14.234 @@ v 2. 100.4 3.)
  and ray3 = v (V3.v 0. 0. 3.) (V3.v 2. 100.4 3.)
  and p3 = V3.(V3.v 1. 0. 3. + (smul 14.234 @@ v 2. 100.4 3.)) in
  (not @@ mem ray1 p1) && (not @@ mem ray2 p2) && (not @@ mem ray3 p3)
