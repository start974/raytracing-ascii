open Geometry

module Camera : module type of Camera

module Screen : module type of Screen

module Lights : module type of Lights

module Objects : module type of Objects

type t

val make : Camera.t -> Screen.t -> Lights.t -> Objects.t -> t

val camera : t -> Camera.t

val screen : t -> Screen.t

val lights : t -> Lights.t

val objects : t -> Objects.t

val ray : t -> int -> int -> Ray.t

val get_color : t -> int -> int -> Objects.ObjectScene.color

val screen_size : t -> int * int
