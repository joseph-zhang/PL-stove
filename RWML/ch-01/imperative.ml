(* Though OCaml is mainly functional, it supports imperative programming *)

(* ---- Arrays ---- *)
let numbers = [|1;2;3;4|]
(* val numbers : int array = [|1; 2; 3; 4|] *)

(* Arrays modification *)
let () =
  numbers.(2) <- 11

(* ---- Mutable Record Fields ---- *)
type running_sum =
  { mutable sum: float;
    mutable sum_sq: float;
    mutable samples: int; }

let mean rsum = rsum.sum /. Float.of_int rsum.samples
(* val mean : running_sum -> float = <fun> *)

let stdev rsum = Float.sqrt (rsum.sum_sq /. Float.of_int rsum.samples -.
                             (rsum.sum /. Float.of_int rsum.samples) ** 2.)
(* val stdev : running_sum -> Float.t = <fun> *)

let create () = {sum = 0.; sum_sq = 0.; samples = 0}
(* val create : unit -> running_sum = <fun> *)

let add_item rsum x =
  rsum.samples <- rsum.samples + 1;
  rsum.sum <- rsum.sum +. x;
  rsum.sum_sq <- rsum.sum_sq +. x *. x
(* val add_item : running_sum -> float -> unit = <fun> *)

(* ---- Refs ---- *)
let x = {contents = 0}
(* val x : int ref = {contents = 0} *)

let x' = ref 0
(* val x' : int ref = {contents = 0} *)

(* refs modification *)
let () =
  x' := 6

(* get the contents of a ref *)
let () =
  x := !x' + 1

(* Loops: for and while *)
let permute array =
  let length = Array.length array in
  for i = 0 to length - 2 do
    (* pick a j to swap with *)
    let j = i + Random.int (length - i) in
    (* Swap i and j *)
    let tmp = array.(i) in
    array.(i) <- array.(j);
    array.(j) <- tmp
  done
(* val permute : 'a array -> unit = <fun> *)

let find_first_negative_entry array =
  let pos = ref 0 in
  while
    let pos_is_good = !pos < Array.length array in
    let element_is_non_negative = array.(!pos) >= 0 in
    pos_is_good && element_is_non_negative
  do
    pos := !pos + 1
  done;
  if !pos = Array.length array then None else Some !pos
(* val find_first_negative_entry : int array -> int option = <fun> *)
