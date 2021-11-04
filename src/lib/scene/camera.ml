open Gg
open Aux
open Geometry

type t = {position: p3; forward: V3.t; screen: Screen.t}

let up = V3.v 0. 0. 1. (*todo : make this a parameter *)

let make position forward screen = {position; forward; screen}

let replaced ?position ?forward ?screen camera =
  { position= Option.value ~default:camera.position position
  ; forward= Option.value ~default:camera.forward forward
  ; screen= Option.value ~default:camera.screen screen }

let position {position; _} = position

let forward {forward; _} = forward



let middle_screen camera = V3.(position camera + forward camera)

let plane camera = Plane.v (middle_screen camera) camera.forward

let screen_point camera =
  let plane = plane camera in
  fun point -> Plane.apply plane ~up point

let screen_point camera =
  let screen_point = screen_point camera
  and pixel_size = Screen.pixel_3d camera.screen
  and half_resx, half_resy =
    let resx, resy = Screen.size camera.screen in
    (resx / 2, resy / 2)
  in
  fun px py ->
    screen_point
      V2.(
        v
          Float.(of_int Int.(px - half_resx) * pixel_size)
          Float.(of_int Int.(py - half_resy) * pixel_size))

let ray camera =
  let screen_point = screen_point camera in
  fun x y ->
    let screen_point = screen_point x y in
    Ray.v camera.position V3.(screen_point - camera.position)
