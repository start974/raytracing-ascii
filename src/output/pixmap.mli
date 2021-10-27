module Extension:
sig

    type t =
        | PBM
        | PGM
        | PPM

    val to_string : t -> string
    (** [to_string] get extension using to make file (ex: ".pbm")*)

end

module PixelMaker:
sig
    module PixelPBM: Image.Pixel with type t = bool
    module PixelPGM: Image.Pixel with type t = int
    module PixelPPM: Image.Pixel with type t = (int * int * int)

    val pixel_PBM: bool -> PixelPBM.t
    (**[pixel_PBM] make a PBM pixel *)

    val pixel_PBM_default: PixelPBM.t
    (**[pixel_PBM] make a PBM default pixel *)

    val pixel_PGM: int -> PixelPGM.t
    (**[pixel_PGM] make a PGM pixel
    (raise [Invalid_argument] if value is not between 0 and 255*)

    val pixel_PGM_default: PixelPGM.t
    (**[pixel_PBM] make a PGM default pixel *)

    val pixel_PPM: int -> int -> int -> PixelPPM.t
    (**[pixel_PPM] make a PPM pixel with [r, g, b] values
    (raise [Invalid_argument] if r, g, b values not beetween 0 and 255 *)

    val pixel_PPM_default: PixelPPM.t
    (**[pixel_PBM] make a PPM default pixel *)
end

module ImagePBM : Image.S
module ImagePGM : Image.S
module ImagePPM : Image.S
