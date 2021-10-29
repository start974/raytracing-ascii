module type S = sig
  (** alias of image *)
  type t

  (** [pixel] pixel in image*)
  type pixel

  (** [data] is matrix of mixel (with size width * height)*)
  type data = pixel Array.t Array.t

  val make : int -> int -> pixel -> t
  (** [make] make image with [width], [height], default_pixel*)

  val get_width : t -> int
  (** [get_width] return width of [Image.t] *)

  val get_height : t -> int
  (** [get_height] return height of [Image.t] *)

  val size : t -> int
  (** [size] of image *)

  val get : t -> int -> int -> pixel
  (** [get] return [pixel] at position [x], [y] of [Image.t]
  (raise [Invalid_argument] if [x] or [y] out of bound)
  *)

  val set : t -> int -> int -> pixel -> unit
  (** [set] a pixel [pixel] at position [x], [y] in [Image.t]
  (raise [Invalid_argument] if [x] or [y] out of bound)
  *)

  val to_string : t -> string
  (**[to_string] string*)

  val write : t -> out_channel -> unit
  (** [write] write image [Image.t]*)
end

module type Pixel = sig
  type t

  val write_image : t Array.t Array.t -> Buffer.t
  (*[image to string] convert image of image to string*)
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
end
