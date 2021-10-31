open Gg
open Aux
open Geometry

let ambient ambiant_color ka = V4.mul ka ambiant_color

let lights_contribute lights objects p =
  let illuminate light =
    not
    @@ Array.exists
         (fun obj ->
           let ray = Ray.v p V3.(Light.position light - p) in
           Option.is_some @@ Object.intersection obj ray )
         objects
  in
  Array.filter illuminate lights

let diffuse kd id ns dir_ray =
  let cos_theta = Float.abs V3.(dot dir_ray ns) in
  V4.(cos_theta * mul kd id)

let specular ks is shiness ns dir_ray dir_light =
  let h = V3.(unit (dir_ray + dir_light)) in
  let cos_theta = Float.abs V3.(dot (unit ns) h) in
  let k = Float.(pow cos_theta (shiness / 4.)) in
  V4.(k * mul ks is)