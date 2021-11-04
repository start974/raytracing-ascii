include Stdlib.List

let min li weight default =
  fst
  @@ fold_left
       (fun (candidate, candidate_weight) ele ->
         let weight = weight ele in
         if weight < candidate_weight then (ele, weight)
         else (candidate, candidate_weight) )
       (default, weight default)
       li
