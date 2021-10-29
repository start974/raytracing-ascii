type t = {width: int; height: int; aspect_ratio: float}

let make width height aspect_ratio = {width; height; aspect_ratio}

let width {width; _} = width

let height {height; _} = height

let aspect_ratio {aspect_ratio; _} = aspect_ratio

let size {width; height; _} = (width, height)
