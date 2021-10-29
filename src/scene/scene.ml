module Camera = Camera
module Screen = Screen
module Lights = Lights
module Objects = Objects

type t =
  {camera: Camera.t; screen: Screen.t; lights: Lights.t; objects: Objects.t}

let make camera screen lights objects = {camera; screen; lights; objects}

let get_camera {camera; _} = camera

let get_screen {screen; _} = screen

let get_lights {lights; _} = lights

let get_objects {objects; _} = objects

let iter_pos {screen; camera; _} f = Screen.iter screen camera f
