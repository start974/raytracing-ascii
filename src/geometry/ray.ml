open Gg

type t = {origin: p3; direction: v3}

let v origin direction = {origin; direction= V3.unit direction}

let origin v = v.origin

let direction v = v.direction

let abstract_distance_from_point dist line point =
  let {origin; direction} = line in
  let line_vector = V3.unit direction in
  let point_vector = V3.(point - origin) in
  let distance_of_projection_from_origin = V3.dot line_vector point_vector in
  let projection_vector =
    V3.smul distance_of_projection_from_origin line_vector
  in
  let projection = V3.(projection_vector + origin) in
  V3.(dist (projection - point))

let apply {origin; direction} lambda = V3.(origin + smul lambda direction)

let distance_from_point = abstract_distance_from_point V3.norm

let distance_from_point2 = abstract_distance_from_point V3.norm2
