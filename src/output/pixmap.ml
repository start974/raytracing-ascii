    
module Extension = 
struct

    type t =
        | PBM
        | PGM
        | PPM

    let to_string = function
        | PBM -> ".pbm"
        | PGM -> ".pgm"
        | PPM -> ".ppm"

    let number_string = function
    | PBM -> "P1"
    | PGM -> "P2"
    | PPM -> "P3"

end


module Pixel = 
struct
    
    type t =
        | PBM of bool
        | PGM of int
        | PPM of (int * int * int)

    let to_string pixel =
    match pixel with
    | PBM x -> string_of_int (Bool.to_int x)
    | PGM x -> string_of_int x
    | PPM (x, y, z) ->
        string_of_int x ^ " " ^ 
        string_of_int y ^ " " ^
        string_of_int z
    
    let default_value = function 
    | Extension.PBM -> PBM false
    | Extension.PGM -> PGM 0
    | Extension.PPM -> PPM (0, 0, 0)

    let max_value = function
    | Extension.PBM -> 2
    | Extension.PGM -> 15
    | Extension.PPM -> 255
end

type t = 
{
    extension : Extension.t;
    width : int;
    height : int;
    data : Pixel.t Array.t
}


let make width height extension = 
{
    extension = extension;
    width = width;
    height = height;
    data = Array.make (width * height) (Pixel.default_value extension);
}

let get_width image =
    image.width

let get_height image =
    image.height

let get_extension image = 
    image.extension

let get_max_value image = 
    Pixel.max_value (get_extension image)

let check_in_image image x y = 
    if x > image.width then
        raise (Invalid_argument "x > image.widht")
    else if y > image.height then
        raise (Invalid_argument "y > image.height")



let check_pixel_valid pixel =
    let raise_if_sup_255 x max_value = 
        if x > max_value || x < 0 then 
            raise (Invalid_argument "value > image.height")
    in
    match pixel with
    | Pixel.PGM x -> raise_if_sup_255 x (Pixel.max_value Extension.PGM)
    | Pixel.PPM (x, y, z) ->
        let max_value = (Pixel.max_value Extension.PPM) in
        raise_if_sup_255 x max_value;
        raise_if_sup_255 y max_value;
        raise_if_sup_255 z max_value
    | _ -> ()


let get_data_index image x y =
    check_in_image image x y;
    y * image.width + x

let get image x y =
    let index = get_data_index image x y in
    Array.get image.data index


let set image x y pixel =
    check_pixel_valid pixel;
    let index = get_data_index image x y in
    Array.set image.data index pixel


let size_string width height = 
    string_of_int width ^ " " ^ string_of_int height

let limit_string = 70

let f_fold_string (count, acc) x = 
        let elm = Pixel.to_string x in
        let size = String.length elm in
        if count + size >= limit_string then
            (size, acc ^ "\n" ^ elm)
        else
            (count + size + 1, acc ^ " " ^ elm)

let data_to_string data =
    let (_, res) = Array.fold_left f_fold_string (0, "") data in
    String.sub res 1 (String.length res - 1)


let to_string image = 
    (Extension.number_string (get_extension image)) ^ "\n" ^
    (size_string (get_width image) (get_height image)) ^ "\n" ^
    (string_of_int (get_max_value image)) ^ "\n" ^ 
    (data_to_string image.data)

