open Gg
open Aux

type t = {width: int; height: int; width_3d: float}

let make width height width_3d = {width; height; width_3d}

let width {width; _} = width

let height {height; _} = height

let width_3d {width_3d; _} = width_3d

let height_on_width {width; height; _} = Float.(of_int height / of_int width)

let height_3d screen = Float.(height_on_width screen * width_3d screen)

let pixel_3d screen = Float.(width_3d screen / of_int (width screen))

let size {width; height; _} = (width, height)

let size_3d s = V2.v (width_3d s) (height_3d s)
