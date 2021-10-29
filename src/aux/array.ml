include Stdlib.Array

let init_matrix dimx dimy f = init dimx (fun x -> init dimy (f x))
