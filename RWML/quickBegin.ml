(* Begin With Ocaml *)
(* First we can try it in utop REPL *)
(* Note that ;; is the notification of 'end' *)

(* Try to define functions *)
(* Types in Ocaml is very strict *)
let averageFloat a b =
  (a +. b) /. 2.0

let averageInt a b =
  (a + b) / 2

(* an example of type transfer *)
let p = (float 1 +. 2.5)

(* an example of recursive function *)
let rec range a b =
  if a > b then []
  else a :: range (a + 1) b
