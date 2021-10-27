module PixelMaker :
sig
    module Pixel: Image.Pixel

    type t

    val make: char List.t -> t
    (** [make] a pixel maker ascii 
    (raise [Invalid_argument] if array empty) *)

    val default_pixel: t -> Pixel.t
    (**[default_pixel] get defailt pixel of PixelMaker*)

    val create_pixel: t -> float -> Pixel.t
    (**[create_pixel] make a pixel with [intensity] of this pixel 
    (raise [Invalid_argument] if [intensity] not between 0 and 1) *)
end

module Image: Image.S