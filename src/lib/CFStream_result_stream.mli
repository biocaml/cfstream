(** Higher-order functions for streams of results

    The functions in this module can be used to iterate on a stream of
    results with a function that only considers the non-error
    case. The iterated function thus doesn't need to do the pattern
    match on each [Result] value.

    For each kind of iteration, two versions are proposed. One for
    total functions (that is, functions that cannot fail), the other
    for partial functions (they are assumed to return a [Result] in
    this case).
*)
open Core_kernel.Std

type ('a, 'b) t = ('a, 'b) Result.t Stream.t

val map : ('a, 'e) t -> f:('a -> 'b) -> ('b, 'e) t
(** [map rs ~f] maps [Ok] results with a total function [f] *)

val map' : ('a, 'e) t -> f:('a -> ('b, 'e) Result.t) -> ('b,'e) t
(** [map' rs ~f] maps [Ok] results with a partial function [f] *)

val fold : ('a, 'e) t -> init:'b -> f:('b -> 'a -> 'b) -> ('b, 'e) Result.t
(** [fold rs ~init ~f] computes a value by iterating [f] on each [Ok]
    element of [rs] starting from [init]. The computation stops with
    an [Error] case as soon as one is met. *)

val fold' : ('a, 'e) t -> init:'b -> f:('b -> 'a -> ('b, 'e) Result.t) -> ('b, 'e) Result.t
(** Same as [fold], but for partial functions. The computation stops
    with an [Error] case when [f] returns it. *)
