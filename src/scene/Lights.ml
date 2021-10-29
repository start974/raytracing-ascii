op

module AmbiantLight = struct
  type t = V3.t
end

type t = {ambiant: float}

let make ambiant = {ambiant}

let get_ambiant {ambiant} = ambiant