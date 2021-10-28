module Camera = Camera
module Screen = Screen
module Lights = Lights
module Objects = Objects

type t =
  {camera: Camera.t; screen: Screen.t; lights: Lights.t; objects: Objects.t}

let make camera screen lights objects = {camera; screen; lights; objects}

let get_camera scene = scene.camera

let get_screen scene = scene.screen

let get_lights scene = scene.lights

let objects scene = scene.objects
