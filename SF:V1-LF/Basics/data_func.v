(*
before write something, note that the coq contains three different language
1. vernacular: deal with definition (e.g. Theorem, Proof, Qed..)
2. tactics: work for proof process (e.g. intros, exact..)
3. Gallina: basic desciption of coq functional programming, (e.g. forall A : Prop, A -> A)
 *)
(* This chapter concentrates on the concept of coq fuctional programming. *)

(* coq let you construct your own type (Though many of them has been implemented in standard library) *)
(* a new type contains day1 to day7 in a week *)
Inductive day : Type :=
| monday : day
| tuesday : day
| wednesday : day
| thursday : day
| friday : day
| saturday : day
| sunday : day.

(* a function to process a  day *)
(* Though coq can do Type Inference, it is recommended to add type annotation *)
Definition nxt_day (d:day) : day :=
  match d with
  | monday => tuesday
  | tuesday => wednesday
  | wednesday => thursday
  | thursday => friday
  | friday => saturday
  | saturday => sunday
  | sunday => monday
  end.

(* now we can check our definition *)
Compute (nxt_day sunday).

(* For another way, the result can be written as an assertion *)
Example test_next_day:
  (nxt_day (nxt_day monday)) = wednesday.

(* and then ask coq to verify it *)
Proof. simpl. reflexivity. Qed.

(* Now we try to define the boolean type *)
Inductive bool : Type :=
| true : bool
| false : bool.

(* some functions to process boolean value *)
Definition negb (b:bool) : bool :=
  match b with
  | true => false
  | false => true
  end.

Definition andb (b1:bool) (b2:bool) : bool :=
  match b1 with
  | true => b2
  | false => false
  end.

Definition orb (b1:bool) (b2:bool) : bool :=
  match b1 with
  | true => true
  | false => b2
  end.

(* add infix notations *)
Notation "x && y" := (andb x y).
Notation "x || y" := (orb x y).

(* check our definition *)
Example test_orb : false || false || false || true = true.
Proof. simpl. reflexivity. Qed.

(* ask coq to print the type of an expression *)
Check true.
Check monday.
Check orb. (* Functions are also data values *)

(* --------------------------------------------------------------------------------------------------------------------------------------*)

(* the types we previous defined are all "enumerated types", which is represented as a finite set *)
(* every element of this kind of type is a is just a bare constructor *)
(* However, constructors often have their own params, becomes value constructor *)
Inductive rgb : Type :=
| red : rgb
| green : rgb
| blue : rgb.

Inductive color : Type :=
| black : color
| white : color
| primary : rgb -> color.

(* a related function of color *)
Definition monochrome (c:color) : bool :=
  match c with
  | black => true
  | white => true
  | primary p => false
  end.

(* the wildcard pattern is widely used in practise *)
Definition isred (c:color) : bool :=
  match c with
  | black => false
  | white => false
  | primary red => true
  | primary _ => false
  end.

(* Module system help us organize large developments, In this chapter, *)
(* we will not write the module in a independent file, but write it here directly so that *)
(* it does not interfere with the one from the standard library *)
Module Natplayground.

  (* an interesting implementation of nat *)
  Inductive nat : Type :=
  | o : nat (* here we use character 'o' to represent number 0 *)
  | S : nat -> nat.

  (* a predecessor function for our nat *)
  Definition pred (n:nat) : nat :=
    match n with
    | o => o
    | S n' => n'
    end.

End Natplayground.

(* So the following two lines are both represent the natural number 2, *)
(* the first one is conducted by standard library, and the second one is conducted by our own module Natplayground*)
Check (S (S 0)).
Check (Natplayground.S (Natplayground.S Natplayground.o)).

Compute (Natplayground.pred (Natplayground.S Natplayground.o)).
Compute (pred (S 0)).

(* you may find the different between the function like pred and S, *)
(* Though they will process a nat to another, but S contains no compute!! It is just a way of writing down numbers. *)

(* --------------------------------------------------------------------------------------------------------------------------------------------*)

(* In fact, the pattern matching is not enough, we always need a stronger method -- recursion. *)
(* the keyword Fixpoint is useful when we define a kind of function, its idea can be very easy -- F (a) = a *)
(* i.e. apply a val by itself again, again and again.. *)
Fixpoint evenb (n:nat) : bool :=
  match n with
  | 0 => true
  | S 0 => false
  | (S (S n')) => evenb n'
  end.

(* then we use it to define oddb *)
Definition oddb (n:nat) : bool := negb (evenb n).

(* check them~ *)
Example test_evenb: oddb 1 = true.
Proof. simpl. reflexivity. Qed.
Example test_oddb: evenb 4 = true.
Proof. simpl. reflexivity. Qed.

(* Now we redefine some standard number functions for nat *)
Module Natplayground2.
  Fixpoint plus (n:nat) (m:nat) : nat :=
    match n with
    | 0 => m
    | S n' => S (plus n' m)
    end.

  Fixpoint mult (n m : nat) : nat := (* here we write n and m togerther, a shorthand*)
    match n with
    | 0 => 0
    | S n' => plus m (mult n' m)
    end.

  Fixpoint minus (n m : nat) : nat :=
    match n, m with
    | 0, _ => 0
    | S _, 0 => n
    | S n', S m' => minus n' m'
    end.
End Natplayground2.
