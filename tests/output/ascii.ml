open Output

module To_test = struct
  module Image = Image_ascii
  module PixelMaker = MkPixel_ascii
end

let test_pixelMaker_default () =
  To_test.PixelMaker.(
    let pixel_maker = make ".-_" in
    Alcotest.(check char) "default pixel" '.' (default_pixel pixel_maker))

let test_pixelMaker_value () =
  let make_pixel = To_test.PixelMaker.(create_pixel @@ make ".-_") in
  let test_index x c =
    Alcotest.(check char) ("pixel " ^ string_of_float x) c (make_pixel x)
  in
  test_index 0. '.' ;
  test_index 1. '_' ;
  test_index 0.25 '-' ;
  test_index 0.8 '_'

let test_image () =
  let output_string = "..\n..\n.0\n" in
  To_test.Image.(
    let make_pixel = To_test.PixelMaker.(create_pixel @@ make ".0") in
    let image = make 2 3 @@ make_pixel 0. in
    Alcotest.(check char) "pixel is default" '.' (get image 1 2) ;
    set image 1 2 @@ make_pixel 1. ;
    Alcotest.(check char) "pixel is set" '0' (get image 1 2) ;
    Alcotest.(check string) "image string" output_string (to_string image))

let () =
  let open Alcotest in
  run "ascii"
    [ ( "pixel maker"
      , [ test_case "test pixel maker default" `Quick test_pixelMaker_default
        ; test_case "test pixel maker values" `Quick test_pixelMaker_value ] )
    ; ("image", [test_case "test image" `Quick test_image]) ]
