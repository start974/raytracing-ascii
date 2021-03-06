open Gg
open Geometry

module Camera : module type of Camera

module Screen : module type of Screen

module Objects : module type of Objects

module Object : module type of Object

module Light : module type of Light

type t =
  {camera: Camera.t; ambiant: Color.t; lights: Light.t array; objects: Objects.t}

val make : Camera.t -> color -> Light.t array -> Objects.t -> t
(*[make: camera, ambiant light, lights, objects]*)

val replaced :
     ?camera:Camera.t
  -> ?ambiant:v4
  -> ?lights:Light.t array
  -> ?objects:Objects.t
  -> t
  -> t

val camera : t -> Camera.t

val ray : t -> int -> int -> Ray.t

val get_color : t -> int -> int -> Color.t
