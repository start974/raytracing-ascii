module Extension: 
sig

    type t =
        | PBM
        | PGM
        | PPM

    val to_string : t -> string
    (** get extension using to make file *)

end

module Pixel :
sig
    type t =
        | PBM of bool
        | PGM of int
        | PPM of (int * int * int)
    
    val default_value: Extension.t -> t
    (* make default value with extension *)

    val to_string: t -> string
    (* get string of pixel *)
end


type t
(** Alias of image type *)

val make : int -> int -> Extension.t -> t
(** Create image with:
    - widht
    - height
    - extension
*)

val get_width: t -> int
(** width of image *)

val get_height: t -> int
(** height of image *)

val get_extension: t -> Extension.t
(** extension of image *)

val get_max_value: t -> int
(** max value *)

val get: t -> int -> int -> Pixel.t
(** get pixel of one image with:
    - image
    - x
    - y
 (raise Invalid argument if x or y out of bound)
*)

val set: t -> int -> int -> Pixel.t -> unit
(** set pixel in one image with:
    - image
    - x
    - y
 (raise Invalid argument if x or y out of bound)
*)

val to_string: t -> string
(** convert image to string *)


