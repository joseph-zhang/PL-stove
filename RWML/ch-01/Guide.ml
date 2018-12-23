(* Since we are familiar with Haskell, here just give examples quickly. *)
(* Note that ml files can be loaded in utop REPL like this: #use "xxx.ml" *)
open Core

(* Type inference *)
let sum_if_true (test: int -> bool) (x: int) (y: int) : int =
  (if test x then x else 0)
  + (if test y then y else 0)
(* val sum_if_true : (int -> bool) -> int -> int -> int = <fun> *)


(* Inferring Generic Types *)
let first_if_true test x y =
  if test x then x else y
(* val sum_if_true : (int -> bool) -> int -> int -> int = <fun> *)

(* Tuples *)
let a_tuple = (3, "three")
(* val a_tuple : int * bytes = (3, "three") *)

(* Tuple pattern matching *)
let (x, y) = a_tuple
(* val x : int = 3
   val y : bytes = "three" *)

(* Lists *)
let languages = ["OCaml"; "Haskell"; "Scala"]
(* val languages : bytes list = ["OCaml"; "Haskell"; "Scala"] *)


(* List construction *)
let natual_languages = "French" :: "Spanish" :: []
(* val natual_languages : bytes list = ["French"; "Spanish"] *)

(* List concatenate *)
let concat_list = languages @ natual_languages
(* val concat_list : bytes list =
   ["OCaml"; "Haskell"; "Scala"; "French"; "Spanish"] *)

(* List pattern matching *)
let my_language languages =
  match languages with
  | first :: _ -> first
  | [] -> "Ocaml" (* default choice *)
(* val my_language : bytes list -> bytes = <fun> *)

(* List recursive function *)
let rec list_sum l =
  match l with
  | [] -> 0
  | hd :: tl -> hd + list_sum tl
(* val list_sum : int list -> int = <fun> *)

(* Options *)
let divide x y =
  if y = 0 then None else Some (x / y)
(* val divide : int -> int -> int option = <fun> *)

(* Option pattern matching *)
let downcase_extension filename =
  match String.rsplit2 filename ~on:'.' with
  | None -> filename
  | Some (base, ext) ->
    base ^ "." ^ String.lowercase ext
(* val downcase_extension : string -> string = <fun> *)

(* Define a record type using 'type' *)
type point2d = {x: float; y: float}
(* type point2d = { x : float; y : float; } *)

(* Record pattern matching *)
let magnitude {x = x_pos; y = y_pos} =
  Float.sqrt (x_pos ** 2. +. y_pos ** 2.)

let distance v1 v2 =
  magnitude {x = v1.x -. v2.x; y = v1.y -. v2.y}

(* more records *)
type circle_desc = {center: point2d; radius: float}
type rect_desc = {lower_left: point2d; width: float; height: float}
type segment_desc = {endpoint1: point2d; endpoint2: point2d}

(* Define a variant *)
type scene_element =
  | Circle of circle_desc
  | Rect of rect_desc
  | Segment of segment_desc

(* use variant *)
let is_inside_scene_element point scene_element =
  let open Float.O in
  match scene_element with
  | Circle {center; radius} ->
    distance center point < radius
  | Rect {lower_left; width; height} ->
    point.x > lower_left.x && point.x < lower_left.x + width
    && point.y > lower_left.y && point.y < lower_left.y + height
  | Segment {endpoint1; endpoint2} -> false
(* val is_inside_scene_element : point2d -> scene_element -> bool = <fun> *)

let compare_res = is_inside_scene_element {x=3.; y=7.}
    (Circle {center={x=4.; y=4.}; radius=0.5})
(* val compare_res : bool = false *)
