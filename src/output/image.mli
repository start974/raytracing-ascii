module type S = sig
  (** alias of image *)
  type t

  (** [pixel] pixel in image*)
  type pixel

  (** [data] is matrix of mixel (with size width * height)*)
  type data = pixel Array.t Array.t

  val init : width:int -> height:int -> (int -> int -> pixel) -> t

  (** [init]*)
  val make : width:int -> height:int -> pixel -> t
  (** [make] make image with [width], [height], default_pixel*)

  val width : t -> int
  (** [width] return width of [Image.t] *)

  val height : t -> int
  (** [height] return height of [Image.t] *)

  val size : t -> int
  (** [size] of image *)

  val get : t -> x:int -> y:int -> pixel
  (** [get] return [pixel] at position [x], [y] of [Image.t]
  (raise [Invalid_argument] if [x] or [y] out of bound)
  *)

  val set : t -> x:int -> y:int -> pixel -> unit
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

module Make (Pix : Pixel) : S with type pixel = Pix.t
