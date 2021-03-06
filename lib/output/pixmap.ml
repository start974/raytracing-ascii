module Extension = struct
  type t = PBM | PGM | PPM

  let to_string = function PBM -> ".pbm" | PGM -> ".pgm" | PPM -> ".ppm"
end

module type Pixel = sig
  type t

  val to_string : t -> string

  val header_max_value : string

  val header_number_string : string
end

module MakePixel (Pix : Pixel) : Image.Pixel with type t = Pix.t = struct
  type t = Pix.t

  let write_header buffer height width =
    let add_string = Buffer.add_string buffer
    and new_line () = Buffer.add_char buffer '\n'
    and sep () = Buffer.add_char buffer ' ' in
    let add_int x = add_string @@ string_of_int x in
    add_string Pix.header_number_string ;
    new_line () ;
    add_int width ;
    sep () ;
    add_int height ;
    new_line () ;
    add_string Pix.header_max_value ;
    new_line ()

  let add_buffer buffer pixel =
    let pixel_string = Pix.to_string pixel ^ "\n" in
    Buffer.add_string buffer pixel_string

  let write_image data =
    let height = Array.length data and width = Array.length data.(0) in
    let default_size =
      height * width * (String.length Pix.header_max_value + 1)
    in
    let buffer = Buffer.create default_size in
    (* write header *)
    write_header buffer height width ;
    (* write data *)
    Array.iter (Array.iter (add_buffer buffer)) data ;
    buffer
end

module PixelPBM = MakePixel (struct
  type t = bool

  let to_string pixel = string_of_int (Bool.to_int pixel)

  let header_max_value = ""

  let header_number_string = "P1"
end)

module PixelPGM = MakePixel (struct
  type t = int

  let to_string = string_of_int

  let header_max_value = "15"

  let header_number_string = "P2"
end)

module PixelPPM = MakePixel (struct
  type t = int * int * int

  let to_string (r, g, b) =
    string_of_int r ^ " " ^ string_of_int g ^ " " ^ string_of_int b

  let header_max_value = "255"

  let header_number_string = "P3"
end)

module PixelMaker = struct
  module PixelPBM = PixelPBM
  module PixelPGM = PixelPGM
  module PixelPPM = PixelPPM

  let check_int_value max_value value =
    if value > max_value || value < 0 then
      raise (Invalid_argument "invalid value")

  let pixel_PBM (value : bool) = value

  let pixel_PBM_default = false

  let pixel_PGM value = check_int_value 15 value ; value

  let pixel_PGM_default = 0

  let pixel_PPM r g b =
    let check_max_value_ppm = check_int_value 255 in
    check_max_value_ppm r ;
    check_max_value_ppm g ;
    check_max_value_ppm b ;
    (r, g, b)

  let pixel_PPM_default = (0, 0, 0)
end

module ImagePBM = Image.Make (PixelPBM)
module ImagePGM = Image.Make (PixelPGM)
module ImagePPM = Image.Make (PixelPPM)
