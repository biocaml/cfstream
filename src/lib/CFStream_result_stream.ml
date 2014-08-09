open Core_kernel.Std
open Result

module Stream = CFStream_stream

type ('a, 'b) t = ('a, 'b) Result.t Stream.t

let map rs ~f =
  let f = function
    | Ok x -> Ok (f x)
    | Error _ as e -> e
  in
  Stream.map rs ~f

let map_bind rs ~f =
  let f = function
    | Ok x -> f x
    | Error _ as e -> e
  in
  Stream.map rs ~f

let fold (type e) rs ~init ~f =
  let module M = struct exception E of e end in
  let f accu = function
    | Ok x -> f accu x
    | Error e -> raise (M.E e)
  in
  try Ok (Stream.fold rs ~init ~f)
  with M.E e -> Error e


let fold_bind (type e) rs ~init ~f =
  let module M = struct exception E of e end in
  let f accu = function
    | Ok x -> (match f accu x with Ok r -> r | Error e -> raise (M.E e))
    | Error e -> raise (M.E e)
  in
  try Ok (Stream.fold rs ~init ~f)
  with M.E e -> Error e
