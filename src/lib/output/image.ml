open Aux

module type Pixel = sig
  type t

  val write_image : t Array.t Array.t -> Buffer.t
end

module type S = sig
  type t

  type pixel

  type data = pixel Array.t Array.t

  val init : int -> int -> (int -> int -> pixel) -> t

  val make : int -> int -> pixel -> t

  val width : t -> int

  val height : t -> int

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

  let init width height f =
    {width; height; data= Array.init_matrix height width f}

  let make width height default_pixel =
    init width height (fun _ _ -> default_pixel)

  let width image = image.width

  let height image = image.height

  let size image = width image * height image

  let get image x y = image.data.(y).(x)

  let set image x y pixel = image.data.(y).(x) <- pixel

  let get_buffer image = Pix.write_image image.data

  let to_string image = Buffer.contents @@ get_buffer image

  let write image out_channel =
    Buffer.output_buffer out_channel @@ get_buffer image
end
