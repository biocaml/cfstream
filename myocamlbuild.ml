open Printf
open Solvuu_build.Std
open Solvuu_build.Util

let project_name = "cfstream"
let version = "1.2.1"

let lib : Project.item =
  Project.lib project_name
    ~pkg:project_name
    ~dir:"lib"
    ~style:`Basic
    ~findlib_deps:["core_kernel"]
    ~ml_files:(`Add ["CFStream_about.ml"])

let test : Project.item =
  Project.app "cfstream-test"
    ~file:"app/cfstream_test.ml"
    ~findlib_deps:["oUnit"]
    ~internal_deps:[lib]

let ocamlinit_postfix = [
  "open Core_kernel.Std";
  "open CFStream";
]

let optional_pkgs = ["oUnit"]

let items =
  [lib;test] |>
  List.filter ~f:(fun x -> Project.dep_opts_sat x optional_pkgs)

let () = Project.solvuu1 items
    ~project_name ~version ~ocamlinit_postfix
