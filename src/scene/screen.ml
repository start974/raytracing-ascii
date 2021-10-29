open Aux

type t = {width: int; height: int; aspect_ratio: float}

let make width height aspect_ratio = {width; height; aspect_ratio}

let width {width; _} = width

let height {height; _} = height

let max_width {width; _} = Float.(of_int width - 1.)

let max_height {height; _} = Float.(of_int height - 1.)

let aspect_ratio {aspect_ratio; _} = aspect_ratio

let size {width; height; _} = (width, height)
