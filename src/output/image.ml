module type Pixel = sig
  type t

  val write_image : t Array.t Array.t -> Buffer.t
end

module type S = sig
  type t

  type pixel

  type data = pixel Array.t Array.t

  val make : int -> int -> pixel -> t

  val get_width : t -> int

  val get_height : t -> int

  val size : t -> int

  val get : t -> int -> int -> pixel

  val set : t -> int -> int -> pixel -> unit

  val to_string : t -> string

  val write : t -> out_channel -> unit
end

module Make (Pix : Pixel) : S with type pixel = Pix.t = struct
  type pixel = Pix.t

  type data = pixel Array.t Array.t

  type t = {width: int; height: int; data: data}

  let make width height default_pixel =
    {width; height; data= Array.make_matrix height width default_pixel}

  let get_width image = image.width

  let get_height image = image.height

  let size image = get_width image * get_height image

  let get image x y = image.data.(y).(x)

  let set image x y pixel = image.data.(y).(x) <- pixel

  let get_buffer image = Pix.write_image image.data

  let to_string image = Buffer.contents @@ get_buffer image

  let write image out_channel =
    Buffer.output_buffer out_channel @@ get_buffer image

  module Buffered = struct
    type b = {image: t; mutable x: int; mutable y: int}

    let make image = {image; x= 0; y= 0}

    let add_pixel buff_image pixel =
      let {image; x; y} = buff_image in
      set image x y pixel ;
      if x + 1 <= get_width image then buff_image.x <- x + 1
      else if y + 1 <= get_height image then (
        buff_image.x <- 0 ;
        buff_image.y <- y + 1 )

    let get_image {image; _} = image
  end
end
