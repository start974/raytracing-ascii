type t

module AmbiantLight : sig
  type t

  val make : int -> int -> int -> t

  val get_color : t -> Objects.ObjectScene.color
end

val make : AmbiantLight.t -> t

val get_ambiant : t -> AmbiantLight.t

(*
type ambiantLight

(* TODO add other lights*)
type light = ambiantLight

val nearest_intesection : t -> ray -> light
(* intersection with nearest light *)
*)