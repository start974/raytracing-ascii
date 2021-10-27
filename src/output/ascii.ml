module Image 
module PixelMaker =
struct

  module Pixel: Image.Pixel with type t = char = 
  struct
    type t = char
    let write_image out_channel data = 
      let size = Array.length data * (Array.length data.(0) + 1) in
      let buff = Buffer.create size in
      Array.iter (fun arr_l ->
          Array.iter (Buffer.add_char buff) arr_l;
          Buffer.add_char buff '\n';
          )
        data;
      Buffer.output_buffer out_channel buff
  end
    
  type t = Pixel.t Array.t
  
  let make char_list = 
    if List.length char_list == 0 then
      raise (Invalid_argument "array empty")
    else
      Array.of_list char_list
  

  let default_pixel pix_maker =
    pix_maker.(0)

  let check_intensity intensity = 
    if intensity < 0. || intensity > 1. then
      raise (Invalid_argument "intnsity of not between 0 and 1")
  
  let length_float arr = float_of_int @@ Array.length arr

  let create_pixel pix_maker intensity =
    check_intensity intensity;
    let float_index = Float.round @@ length_float pix_maker *. intensity in
    let index = int_of_float float_index in
    pix_maker.(index)
end


module Image = Image.Make (PixelMaker.Pixel)