(* Variables in OCaml *)
open Base

(* 'let' binding *)
let languages = "OCaml,haskell,Idris,Coq"

let dashed_languages =
  let language_list = String.split languages ~on:',' in
  String.concat ~sep:"-" language_list
(* val dashed_languages : Base.string = "OCaml-haskell-Idris-Coq" *)

(* Pattern matching *)
let upcase_first_entry line =
  match String.split ~on:',' line with
  | [] -> assert false
  | first :: rest -> String.concat ~sep:"," (String.uppercase first :: rest)
(* val upcase_first_entry : Base.string -> Base.string = <fun> *)
