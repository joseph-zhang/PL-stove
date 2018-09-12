(* This chapter will introduce a structure named list. *)

(* Inductive let us define a new type,
and the constructor may contains multiple params. *)
(* the constructor pair below is a value constructor. *)
Inductive natprod : Type :=
| pair : nat -> nat -> natprod.

Definition fst (p : natprod) : nat :=
  match p with
  | pair x y => x
  end.

Definition snd (p : natprod) : nat :=
  match p with
  | pair x y => y
  end.

(* the notation log *)
(* Note that the white spaces in "( x, y )" are necessary *)
Notation "( x , y )" := (pair x y).

(* prove an obvious fact *)
Theorem surjective_paring : forall (p : natprod),
    p = (fst p, snd p).
Proof.
  intros p. destruct p as [n m]. simpl. reflexivity.
Qed.

(* ---------------------------------------------------------------------------------------------------------------------- *)
(* To introduce a more powerful structure, we expand pair to list *)
Inductive natlist : Type :=
| nil : natlist
| cons : nat -> natlist -> natlist.

(* a brief notation *)
Notation "x :: l" := (cons x l)
                         (at level 60, right associativity).
Notation "[]" := nil.
Notation "[ x ; .. ; y ]" := (cons x .. (cons y nil) ..).

(* some functions on list structure *)
Fixpoint repeat (n count : nat) : natlist :=
  match count with
  | 0 => nil
  | S count' => n :: (repeat n count')
  end.

Fixpoint length (l : natlist) : nat :=
  match l with
  | nil => 0
  | h :: t => S (length t)
  end.

Fixpoint append (l1 l2 : natlist) : natlist :=
  match l1 with
  | nil => l2
  | h :: t => h :: (append t l2)
  end.

(* head with default value *)
Definition head (default : nat) (l : natlist) : nat :=
  match l with
  | nil => default
  | h :: t => h
  end.

Definition tail (l : natlist) : natlist :=
  match l with
  | nil => nil
  | h :: t => t
  end.
