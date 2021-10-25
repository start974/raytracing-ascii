open Output

let () = 
  let image = Pixmap.make 10 10 PixExt.PPM in
  Pixmap.set image 5 5 (PixPixel.PPM (255, 100, 222));
  print_endline (Pixmap.to_string image);
  