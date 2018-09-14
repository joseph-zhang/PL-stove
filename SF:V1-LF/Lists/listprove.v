(* Now we are going to prove some facts of lists. *)

Require Export natlist.
Require Export induction_proof.

Notation "x ++ y" := (append x y)
                       (right associativity, at level 60).

Definition pred (n : nat) : nat :=
  match n with
  | 0 => 0
  | S n' => n'
  end.

(* Some obvious facts *)
Theorem nil_app : forall l : natlist,
    [] ++ l = l.
Proof. reflexivity. Qed.

Theorem tail_len_pred : forall l : natlist,
    pred (length l) = length (tail l).
Proof. intros l.
       destruct l as [|n l'].
       - reflexivity.
       - simpl. reflexivity.
Qed.

(* inductive of list structure *)
Theorem app_assoc : forall l1 l2 l3 : natlist,
    (l1 ++ l2) ++ l3 = l1 ++ (l2 ++ l3).
Proof. intros l1 l2 l3.
       induction l1 as [| n l1' IHl1'].
       (* l2 ++ l3 = l2 ++ l3 *)
       - reflexivity.
       (* (n::l1' ++ l2) ++ l3 = (n::l1') ++ (l2 ++ l3) => simpl *) 
       (* n :: (l1' ++ l2) ++ l3 = n :: (l1' ++ (l2 ++ l3)) *)
       - simpl. rewrite <- IHl1'. reflexivity.
Qed.

(* another example *)
(* first define a function to reverse a list *)
Fixpoint rev (l : natlist) : natlist :=
  match l with
  | nil => nil
  | n :: t => (rev t) ++ [n]
  end.


Lemma app_len : forall l1 l2 : natlist,
    length (l1 ++ l2) = (length l1) + (length l2).
Proof. intros l1 l2. induction l1 as [| n l' IHl1'].
       - reflexivity.
       - simpl. rewrite -> IHl1'. reflexivity.
Qed.

Theorem rev_len : forall l : natlist,
    length (rev l) = length l.
Proof. intros l. induction l as [| n l' IHl'].
       - reflexivity.
       - simpl. (* here we should prove the lemma app_len *)
         rewrite -> app_len. simpl.
         rewrite -> IHl', plus_comm. reflexivity.
Qed.

(* -------------------------------------------------------------------------------------------------------------------*)
(* Sometimes we must return a value, but it is not explicit *)
(* In this situation, the Options type is helpful. it is similar to  Maybe Monad in Haskell *)
Inductive natoption : Type :=
| Some : nat -> natoption
| None : natoption.

(* obviously, it also can be define as this *)
Inductive Maybe : Type :=
| just : nat -> Maybe
| nothing : Maybe.

(* now define a function to acquire n-th element in a list *)
(* Note that this element may not exist *)
Fixpoint nth_error (l:natlist) (n : nat) : nat :=
  match l with
  | nil => nothing
  | a :: l' => if beq_nat n 0 then just a
              else nth_error l' (pred n)
  end.
