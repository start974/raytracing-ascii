open Output

let () = 
  let mkPix = MkPixel_ascii.make ['0'; '1'] in
  let default_pix = MkPixel_ascii.default_pixel mkPix in
  let image = Image_ascii.make 10 5 default_pix in 
  Image_ascii.write stdout image;
  