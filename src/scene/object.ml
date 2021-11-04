open Geometry
open Aux

type geometry =
  | OSphere of Sphere.t
  | OPlane of Plane.t
  | OTriangle of Triangle.t

type material =
  { ka: Color.t
  ; kd: Color.t
  ; ks: Color.t
  ; reflexivity: float
  ; refraction_index: float
  ; opacity: float }

type t = {geometry: geometry; material: material}

let make geometry material = {geometry; material}

let sphere center radius material =
  let geometry = OSphere (Sphere.v center radius) in
  make geometry material

let plane origin normal material =
  let geometry = OPlane (Plane.v origin normal) in
  make geometry material

let triangle p1 p2 p3 material =
  let geometry = OTriangle (Triangle.v p1 p2 p3) in
  make geometry material

let mesh arr material = Array.map (fun t -> make (OTriangle t) material) arr

let material {material; _} = material

let normal_surface {geometry; _} p =
  match geometry with
  | OSphere s ->
      Sphere.normal s p
  | OPlane p ->
      Plane.normal p
  | OTriangle t ->
      Triangle.normal t

let shift_point ?(eps = 0.0001) object_scene p =
  let normal = normal_surface object_scene p in
  V3.(p + (eps * normal))

let intersection {geometry; _} ray =
  match geometry with
  | OSphere s ->
      Sphere.intersection s ray
  | OPlane p ->
      Plane.intersection p ray
  | OTriangle t ->
      Triangle.intersection t ray

let reflexion ?(eps = 0.0001) obj ray =
  let p = Option.get @@ intersection obj ray and dir_ray = Ray.direction ray in
  let normal = normal_surface obj p in
  let cos_theta = V3.dot dir_ray normal in
  let dir = V3.(dir_ray - (Float.(2. * cos_theta) * normal)) in
  let p' = V3.(p + (eps * unit dir)) in
  Ray.v p' dir

(** 
  formula used
  m × i + (m × C − \sqrt{1 − m^2 (1 − C^2)}) × n
  m : (n1 / n2)
  i: dir_ray
  n: normal
  C: - n . i
*)
let refraction ?(eps = 0.0001) obj n1 ray =
  let {material= {refraction_index; _}; _} = obj
  and dir_ray = Ray.direction ray in
  let p = Option.get @@ intersection obj ray in
  let normal = normal_surface obj p in
  let cos_theta = V3.dot dir_ray normal and m = Float.(n1 / refraction_index) in
  (* TODO weard cos_theta is always negative ...*)
  let cos_theta1, m =
    if cos_theta > 0. then (cos_theta, 1. /. m) else (-.cos_theta, m)
  in
  let cos_theta2 = Float.(sqrt (1. - (square m * (1. - square cos_theta1)))) in
  let dir =
    V3.((m * dir_ray) + (Float.((m * cos_theta1) - cos_theta2) * normal))
  in
  let p' = V3.((eps * unit dir) + p) in
  Ray.v p' dir
