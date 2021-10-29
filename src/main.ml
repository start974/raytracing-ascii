open Output

let () =
  let default_pix = MkPixel_pixmap.pixel_PBM_default in
  let image = Image_PBM.make 10 5 default_pix in
  Image_PBM.set image 2 0 @@ MkPixel_pixmap.pixel_PBM true ;
  let file = open_out "test.pbm" in
  Image_PBM.write image file ; close_out file
(*
  let default_pix = MkPixel_pixmap.pixel_PGM_default in
  let image = Image_PGM.make 10 5 default_pix in
  Image_PGM.set image 2 0 @@ MkPixel_pixmap.pixel_PGM 15;
  let file = open_out "test.pgm" in 
  Image_PGM.write image file;
  close_out file
  *)
(*
  let default_pix = MkPixel_pixmap.pixel_PPM_default in
  let image = Image_PPM.make 10 5 default_pix in
  Image_PPM.set image 2 0 @@ MkPixel_pixmap.pixel_PPM 255 0 100;
  let file = open_out "test.ppm" in 
  Image_PPM.write image file;
  close_out file
  *)
(*
  let mkPix = MkPixel_ascii.make ['0'; '.'; '_'] in
  let default_pix = MkPixel_ascii.default_pixel mkPix in
  let image = Image_ascii.make 10 5 default_pix in
  Image_ascii.set image 2 0 (MkPixel_ascii.create_pixel mkPix 0.9);
  Image_ascii.write image Stdlib.stdout
  *)
