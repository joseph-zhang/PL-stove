(* List basics *)
open Base

(* List construction *)
let l = [1; 2; 3; 4]
let l1 = 1 :: 2 :: 3 :: 4 :: []

(* List pattern matching *)
let rec sum l =
  match l with
  | [] -> 0
  | hd :: tl -> hd + sum tl
(* val sum : int list -> int = <fun> *)

let rec drop_value l to_drop =
  match l with
  | [] -> []
  | hd :: tl ->
    let new_tl = drop_value tl to_drop in
    if hd = to_drop then new_tl else hd :: new_tl
(* val drop_value : int list -> int -> int list = <fun> *)

(* Pattern matching should be exhaustive *)
let rec drop_zero l =
  match l with
  | [] -> []
  | 0 :: tl -> drop_zero tl
  | hd :: tl -> hd :: drop_zero tl
