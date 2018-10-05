(* A basic concepts of functional programming -- Polymorphism *)
(* := Abstracting functions over the types of the data they manipulate *)

(* -------------------------------------------------------------------------------------------------------------*)
(* Polymorphic Lists *)
(* Recalling the definition of natlist*)
Inductive natList : Type :=
| natNil : natList
| natCons: nat -> natList -> natList.

(* Now we check the type of natList, natNil and natCons *)
Check natList. (* ===> natList : Set *)
Check natNil.  (* ===> natNil : natList *)
Check natCons. (* ===> natCons : natCons : nat -> natList -> natList *)

(* It is obvious that we can define more list structure like this,*)
(* for example: boolList, strList, listList... *)
(* It is tedious. However, Polymorphism let us define Polymorphic Inductive type *)
Inductive list (X:Type) : Type :=
| nil : list X
| cons : X -> list X -> list X.

(* Now we check the type of list, nil and cons *)
Check list. (* ===> list : Type -> Type *)
Check nil.  (* ===> nil : forall X : Type, list X *)
Check cons. (* ===> cons : forall X : Type, X -> list X -> list X *)

(* not give the polymorphic list an exact type, e.g. nat *)
Check (nil nat). (* ===> nil nat : list nat *)
Check (cons nat). (* ===> cons nat : nat -> list nat -> list nat *)
(* nil and cons are both constructor *)

(* define a list that contains only one element *)
Check (cons nat 3 (nil nat)). (* ===> cons nat 3 (nil nat) : list nat *)

(* define polymorphic repeat function *)
Fixpoint repeats (X : Type) (x : X) (count : nat) : list X :=
  match count with
  | 0 => nil X
  | S count' => cons X x (repeats X x count')
  end.

(* Check the definition *)
Example test_repeat :
  repeats nat 4 2 = cons nat 4 (cons nat 4 (nil nat)).
Proof. reflexivity. Qed.

(* Actually, the annotation of type can be inferred. here is another definition *)
(* Coq was able to use type inference to deduce what the types of X, x, and count must be, based on how they are used. *)
Fixpoint repeats' X x count : list X :=
  match count with
  | 0 => nil X
  | S count' => cons X x (repeats' X x count')
  end.

(* Futhermore, it can do type argument synthesis, define the function again *)
Fixpoint repeats'' X x count : list X :=
  match count with
  | 0 => nil _
  | S count' => cons _ x (repeats'' _ x count')
  end.

(* The `Arguments` directive specifies the name of the function (or constructor)  and then lists its arguments names, *)
(* with curly braces around any arguments to be treated as implicit. just tell coq always to infer the type arguments *)
Arguments nil {X}.
Arguments cons {X} _ _.

(* Use implicit arguments, we can even avoid writing _ *)
Fixpoint repeats''' {X : Type} x count: list X :=
  match count with
  | 0 => nil
  | S count' => cons x (repeats''' x count')
  end.

Example test_repeat''':
  repeats''' 5 3 = cons 5 (cons 5 (cons 5 nil)).
Proof. reflexivity. Qed.

(* Some useful methods for list *)
Fixpoint append {X : Type} l1 l2 : list X :=
  match l1 with
  | nil => l2
  | cons h t => cons h (append t l2)
  end.

Check (append (cons 5 nil) (cons 5 (cons 3 nil))). (* ===> ~ : list nat *)

Fixpoint length {X : Type} (l : list X) : nat :=
  match l with
  | nil => 0
  | cons _ l' => S (length l')
  end.

(* This time, the local information is not enough *)
(* Cannot infer the implicit parameter X of nil *)
Fail Definition mynil := nil.

(* we can force the implicit arguments to be explicit *)
(* Compare terminal information between following two check statement *)
Check @nil.  (* ===> @nil : forall X : Type, list X *)
Check nil.   (* ===> nil : list ?X where ?X : [ |- Type] *)

Definition myNatNil := @nil nat.
Check myNatNil. (* ===> myNatNil : list nat *)

(* now define notations for our polymorphic list *)
Notation "x :: y" := (cons x y) (at level 60, right associativity).
Notation "[ ]" := nil.
Notation "[ x ; .. ; y ]" := (cons x .. (cons y []) ..).
Notation "x ++ y" := (append x y) (at level 60, right associativity).

Check ([1;2] ++ []). (* ===> [1; 2] ++ [] : list nat *)


(* -------------------------------------------------------------------------------------------------------------*)
(* Polymorphic Pairs *)
(* we can also define polymorphic pairs, just like the pair of numbers *)
Inductive prod X Y : Type :=
| pair : X -> Y -> prod X Y.

(* define implicit parameter for constructor *)
Arguments pair {X} {Y} _ _.
(* give a notation *)
Notation "( x , y )" := (pair x y).

Check (1,true). (* ===> (1, true) : prod nat bool *)
Check pair 1 true. (* ===> (1, true) : prod nat bool *)
Check @pair nat bool 1 true. (* ===> (1, true) : prod nat bool *)

(* define some useful methods for prod *)
(* note that we need not to write type annotation of X and Y*)
Definition fst {X} {Y} (p : prod X Y) : X :=
  match p with
  | (x, y) => x
  end.

(* note that we can write X and Y together *)
Definition snd {X Y} (p : prod X Y) : Y :=
  match p with
  | (x, y) => y
  end.

(* define zip function for prod *)
Fixpoint zip {X Y} l1 l2 : list (prod X Y) :=
  match l1, l2 with
  | [], _ => []
  | _, [] => []
  | x :: x', y :: y' => (x, y) :: (zip x' y')
  end.

(* -------------------------------------------------------------------------------------------------------------*)
(* Polymorphic Options *)
Module MyOption.
  (* define a new polymorphic type *)
  Inductive option X : Type :=
  | Some (x : X)
  | None.

  Arguments Some {X} _.
  Arguments None {X}.

End MyOption.

Fixpoint beq_nat n m : bool :=
  match n with
  | 0 => match m with
        | 0 => true
        | _ => false
        end
  | S n' => match m with
           | 0 => false
           | S m' => (beq_nat n' m')
           end
  end.

(* now rewrite nth-error function *)
Fixpoint nth_error {X} l n : option X :=
  match l with
  | [] => None
  | a :: l' => match n with
              | 0 => Some a
              | S n' => nth_error l' n'
              end
  end.

Example testOption1:
  nth_error [1;2;3;4] 3 = Some 4.
Proof. reflexivity. Qed.

Example testOption2:
  nth_error [1;2;3;4] 4 = None.
Proof. reflexivity. Qed.
