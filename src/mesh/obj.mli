type t

(* v x y z*)
type vertex = P3.t

(* vn x y z*)
type vertex_normal = V3.t

(* vt x y*)
type vertex_texure = V2.t

(* f v1[/vt1][/vn1] v2[/vt2][/vn2] v3[/vt3][/vn3] *)
type face = vertex * vertex_normal option * vertex_texure option

(* g name *)
type group = string

(* o name*)
type obj = string

(*usemtl name*)
type material = string

val parse : in_channel -> t
