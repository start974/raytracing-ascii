include module type of Stdlib.Float

include module type of Gg.Float

val ( + ) : t -> t -> t

val ( * ) : t -> t -> t

val ( / ) : t -> t -> t

val ( - ) : t -> t -> t

val ( -~ ) : t -> t

val is_close : ?eps:t -> t -> t -> bool

val to_deg : t -> t

val to_rad : t -> t
