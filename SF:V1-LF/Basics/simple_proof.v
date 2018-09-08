(* Since the basic notion of datatype and function is introduced, *)
(* here we going to talk about some basic methods of provement *)
(* by using a few tactics in coq: simpl, reflexivity, rewrite and destruct.*)
(*
Before talk about the details, some basic rules should be remembered.
1. The inner process of Example, Theorem, Lemma, Fact and Remark is totally same,
we can choose from them according to  our coding context.
2. These keywords are examples of tactics, which  is a command that is used between
'Proof' and 'Qed' to guide the process of checking some claim we are making.

this chapter will introduce three basic prove methods:
1. Proof by Simplification;
2. Proof by Rewriting;
3. Proof by Case Analysis.
*)
(* --------------------------------------------------------------------------------------------------------------------------*)
(* Proof by Simplification *)
(* When we have a complex term we can use simpl to crunch it down. *)
(* Use reflexivity when your goal is to prove that something equals itself. *)
(* Note that reflexivity does somewhat more simplification than simpl does.
It tries "unfolding" defined terms, replacing them with their right-hand sides. *)

(* In some cases, we don't want to do this kind of unfolding directly, so simpl is needed. *)

Theorem plus_0_n :
  forall n : nat, 0 + n = n.
Proof. intros n. reflexivity. Qed. (*recalling the definition of function plus*)


Theorem mult_0_l :
  forall n : nat, 0 * n = 0.
Proof. intros n. reflexivity. Qed. (*recalling the definition of function mul*)

(* --------------------------------------------------------------------------------------------------------------------------*)
(* Proof by Rewriting *)
(* some examples can not be simplified*)
Theorem plus_id_example: forall n m : nat,
    n = m ->
    n + n = m + m.

  (* here we proof it by using rewrite to  replace n with m in the goal statement *)
Proof.
  intros n m.
  intros H.
  rewrite -> H. reflexivity. Qed.

(* --------------------------------------------------------------------------------------------------------------------------*)
(* Proof by Case Analysis *)
(* In some cases, rewrite cannot work *)

(* now we define a function of equal nat *)
Fixpoint beq_nat (n m : nat) : bool :=
  match n with
  | 0 => match m with
        | 0 => true
        | S m' => false
        end
  | S n' => match m with
           | 0 => false
           | S m' => beq_nat n' m'
           end
  end.

(* think about this throrem, it cannot be rewritten.. *)
Theorem plus_1_neq_0_firsttry : forall n : nat,
    beq_nat (n + 1) 0 = false.

(*
In this situation, we should do case analysis
1> suppose n = 0, then..
2> suppose n = S n', then..
*)
Proof.
  intros n. destruct n as [| n'].
  - reflexivity. (* deal with the case n = 0 *)
  - reflexivity. (* deal with the case n = S n' *)
Qed.
(*The annotation "as [| n']" is called an intro pattern.
 It tells Coq what variable names to introduce in each subgoal*)

(* a more complexed exmaple *)
Theorem andb_commutative : forall b c,
    andb b c = andb c b.
Proof.
  intros b. destruct b. 
  - destruct c. (* b = false, c = ? *)
    + reflexivity.
    + reflexivity.
  - destruct c. (* b = true, c = ? *)
    + reflexivity.
    + reflexivity.
Qed.

(* a more complexed example *)
Theorem andb3_exchange : forall b c d,
    andb (andb b c) d = andb (andb b d) c.
Proof.
  intros b. destruct b.
  - destruct c.
    { destruct d.
      - reflexivity.
      - reflexivity. }
    { destruct d.
      - reflexivity.
      - reflexivity. }
  - destruct c.
    { destruct d.
      - reflexivity.
      - reflexivity. }
    { destruct d.
      - reflexivity.
      - reflexivity. }
Qed.
