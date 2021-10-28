type t = {width: int; height: int; aspect_ratio: float}

let make width height aspect_ratio = {width; height; aspect_ratio}

let get_width screen = screen.width

let get_height screen = screen.height

let get_aspect_ratio screen = screen.aspect_ratio
