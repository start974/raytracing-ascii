open Geometry

module ObjectScene = struct
  type obj = Sphere.t

  type t = {obj: obj; color: Gg.color}

  let make obj color = {obj; color}

  let get_color obj = obj.color
end

type t = ObjectScene.t List.t

let make obj_list = obj_list