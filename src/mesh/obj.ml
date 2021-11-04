open Gg
open Aux


(* v x y z*)
type vertex_point = P3.t
(*
(* vn x y z*)
type vertex_normal = V3.t

(* vt x y*)
type vertex_texure = V2.t
*)
(* f v1[/vt1][/vn1] v2[/vt2][/vn2] v3[/vt3][/vn3] *)
type vertex  = vertex_point (* * vertex_normal option * vertex_texure option*)
type face = vertex * vertex * vertex

(* g name *)
(*type group = string*)

(* o name*)
type obj = string

(*usemtl name*)
(*type material = string*)

type t = {
  arr_face: face array;
  object_name: string option;
}

type file_struct = {
  mutable vertex_points: vertex_point list;
  mutable vertex_normal: vertex_normal list;
  mutable vertex_texures: vertex_texure list;
  mutable faces: face list;
}
let next_line input_channel =
  try input_line in_ch with 
  End_of_file -> exit 0
    in (* process line in this block, then read the next line *)
       process line;
       read_line ();
    
let parse in_channel = 
  let file_struct = {
  vertex_points= [] ;
  vertex_normal= [] ;
  vertex_texures=[] ;
  faces=         [] ;
  } in
  read_all file_struct