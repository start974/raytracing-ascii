(** ascii*)
module Image_ascii : Image.S with type pixel = char = Ascii.Image

module MkPixel_ascii = Ascii.PixelMaker

(** pixmap*)

module Image_PBM : Image.S with type pixel = bool = Pixmap.ImagePBM

module Image_PGM : Image.S with type pixel = int = Pixmap.ImagePGM

module Image_PPM : Image.S with type pixel = int * int * int = Pixmap.ImagePPM

module MkPixel_pixmap = Pixmap.PixelMaker
module Extension_pixmap = Pixmap.Extension
