open Aux

module AmbiantLight = struct
  type t = V3.t

  let make r g b = V3.v (float_of_int r) (float_of_int g) (float_of_int b)

  let get_color light = light
end

type t = {ambiant: AmbiantLight.t}

let make ambiant = {ambiant}

let get_ambiant {ambiant} = ambiant