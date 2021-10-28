open Output

module To_test = struct
  let extension_string = Extension_pixmap.to_string

  let pixel_maker_PBM = MkPixel_pixmap.pixel_PBM

  let pixel_maker_default_PBM = MkPixel_pixmap.pixel_PBM_default

  let pixel_maker_PGM = MkPixel_pixmap.pixel_PGM

  let pixel_maker_default_PGM = MkPixel_pixmap.pixel_PGM_default

  let pixel_maker_PPM = MkPixel_pixmap.pixel_PPM

  let pixel_maker_default_PPM = MkPixel_pixmap.pixel_PPM_default

  module Image_PBM = Image_PBM
  module Image_PGM = Image_PGM
  module Image_PPM = Image_PPM
end

let test_extension_pbm_string () =
  Alcotest.(check string)
    ".pbm extension" ".pbm"
    (To_test.extension_string Extension_pixmap.PBM)

let test_extension_pgm_string () =
  Alcotest.(check string)
    ".pgm extension" ".pgm"
    (To_test.extension_string Extension_pixmap.PGM)

let test_extension_ppm_string () =
  Alcotest.(check string)
    ".pgm extension" ".ppm"
    (To_test.extension_string Extension_pixmap.PPM)

let test_pbm_pixel () =
  Alcotest.(check bool) "pixel to true" true (To_test.pixel_maker_PBM true) ;
  Alcotest.(check bool)
    "pixel default false" false To_test.pixel_maker_default_PBM

let test_pgm_pixel () =
  Alcotest.(check int) "pixel to 14" 14 (To_test.pixel_maker_PGM 14) ;
  Alcotest.(check int) "pixel default 0" 0 To_test.pixel_maker_default_PGM ;
  Alcotest.(check bool)
    "no error" true
    ( try
        let _ = To_test.pixel_maker_PGM 25 in
        false
      with Invalid_argument _ -> (
        try
          let _ = To_test.pixel_maker_PGM (-1) in
          false
        with Invalid_argument _ -> true ) )

let test_ppm_pixel () =
  Alcotest.(check int)
    "pixel r is set to 10" 10
    (let r, _, _ = To_test.pixel_maker_PPM 10 10 250 in
     r ) ;
  Alcotest.(check int)
    "pixel default r is set to 0" 0
    (let r, _, _ = To_test.pixel_maker_default_PPM in
     r ) ;
  Alcotest.(check bool)
    "no error" true
    ( try
        let _ = To_test.pixel_maker_PPM 256 4 2 in
        false
      with Invalid_argument _ -> (
        try
          let _ = To_test.pixel_maker_PPM 3 100 (-1) in
          false
        with Invalid_argument _ -> true ) )

let test_image_pbm () =
  let output_string = "P1\n2 3\n\n0\n0\n0\n0\n0\n1\n" in
  To_test.Image_PBM.(
    let image = make 2 3 false in
    Alcotest.(check bool) "pixel is default" false (get image 1 2) ;
    set image 1 2 true ;
    Alcotest.(check bool) "pixel is set" true (get image 1 2) ;
    Alcotest.(check bool) "pixel is set" true (get image 1 2) ;
    Alcotest.(check string) "image string" output_string (to_string image))

let test_image_pgm () =
  let output_string = "P2\n2 3\n15\n0\n0\n0\n0\n0\n14\n" in
  To_test.Image_PGM.(
    let image = make 2 3 0 in
    Alcotest.(check int) "pixel is default" 0 (get image 1 2) ;
    set image 1 2 14 ;
    Alcotest.(check int) "pixel is set" 14 (get image 1 2) ;
    Alcotest.(check string) "image string" output_string (to_string image))

let test_image_ppm () =
  let output_string =
    "P3\n2 3\n255\n0 0 0\n0 0 0\n0 0 0\n0 0 0\n0 0 0\n0 0 250\n"
  in
  To_test.Image_PPM.(
    let image = make 2 3 (0, 0, 0) in
    Alcotest.(check int)
      "pixel b is default" 0
      (let _, _, g = get image 1 2 in
       g ) ;
    set image 1 2 (0, 0, 250) ;
    Alcotest.(check int)
      "pixel b set default" 250
      (let _, _, g = get image 1 2 in
       g ) ;
    Alcotest.(check string) "image string" output_string (to_string image))

let () =
  let open Alcotest in
  run "pixmap"
    [ ( "PBM"
      , [ test_case "extension pbm string" `Quick test_extension_pbm_string
        ; test_case "make pbm pixel" `Quick test_pbm_pixel
        ; test_case "make pbm image" `Quick test_image_pbm ] )
    ; ( "PGM"
      , [ test_case "extension pgm string" `Quick test_extension_pgm_string
        ; test_case "make pgm pixel" `Quick test_pgm_pixel
        ; test_case "make pbm image" `Quick test_image_pgm ] )
    ; ( "PPM"
      , [ test_case "extension ppm string" `Quick test_extension_ppm_string
        ; test_case "make ppm pixel" `Quick test_ppm_pixel
        ; test_case "make pbm image" `Quick test_image_ppm ] ) ]
