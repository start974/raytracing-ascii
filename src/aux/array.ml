include Stdlib.Array

let init_matrix dimx dimy f = init dimx (fun x -> init dimy (f x))

let min arr weight default =
  fst
  @@ fold_left
       (fun (candidate, candidate_weight) ele ->
         let weight = weight ele in
         if weight < candidate_weight then (ele, weight)
         else (candidate, candidate_weight) )
       (default, weight default)
       arr

let filter pred arr =
  let count = ref 0 in
  let bool_arr =
    init (length arr) (fun i ->
        if pred (get arr i) then (
          count := !count + 1 ;
          true )
        else false )
  in
  let i = ref 0 in
  init !count (fun _ ->
      while not (get bool_arr !i) do
        i := !i + 1
      done ;
      get arr !i )
