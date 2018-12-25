(* Functions in OCaml *)
open Stdio


(* Lambda *)
let transforms = [String.uppercase; String.lowercase]
(* val transforms : (Base.string -> Base.string) Base__List.t = [<fun>; <fun>] *)
let transformed_list =  List.map ~f:(fun g -> g "Hello world") transforms
(* val transformed_list : string list = ["HELLO WORLD"; "hello world"] *)

(* Currying *)
let abs_diff =
  (fun x -> (fun y -> abs(x - y)))
(* val abs_diff : int -> int -> int = <fun> *)
let abs_diff_one =
  abs_diff 1
(* val abs_diff_one : int -> int = <fun> *)
let plus_three =
  (+) 3
(* val plus_three : int -> int = <fun> *)

(* Recursively function*)
let rec find_first_repeat list =
  match list with
  | [] | [_] -> None
  | x :: y :: tl ->
    if x = y then Some x else find_first_repeat (y :: tl)
(* val find_first_repeat : 'a list -> 'a option = <fun> *)

(* Pipe *)
let path = "/usr/bin:/usr/local/bin:/bin:/sbin:/usr/bin"
let () = String.split ~on:':' path
         |> List.dedup_and_sort ~compare:String.compare
         |> List.iter ~f:print_endline

(* Labeling *)
let ratio ~num ~denom = Float.of_int num /. Float.of_int denom
(* val ratio : num:int -> denom:int -> float = <fun> *)

(* Optional Arguments *)
let concat ?sep x y =
  let sep = match sep with None -> "" | Some x -> x in
  x ^ sep ^ y
(* val concat : ?sep:string -> string -> string -> string = <fun> *)

(* another way to define concat *)
let concat' ?(sep="") x y = x ^ sep ^ y

(* normal usage *)
let p = concat "foo" "bar"
let p1 = concat ~sep:":" "foo" "bar"
(* expicit passing *)
let p2 = concat ?sep:None "foo" "bar"
let p3 = concat ?sep:(Some ":") "foo" "bar"
