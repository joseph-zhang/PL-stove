(* this chapter, a basic prove method is introduced -- induction *)
(* we proved that neutral element for + on the left, here consider about 0 at the right. *)

Theorem plus_n_0_bad : forall n : nat,
    n = n + 0.
(* you may find that the simpl or destrcut cannot work in this circumstance.*)
Proof.
  intros n. destruct n as [| n'].
  - (* n = 0 *) reflexivity. (* no problem~ 0 = 0 + 0 *)
  - (* n = S n' *) simpl. (* cannot go on, S n' equal? (S n') + 0 *)
Abort.

(* here introduce a new tactic named 'induction' *)
Theorem plus_n_0_again : forall n : nat,
    n = n + 0.
Proof.
  intros n. induction n as [| n' IHn']. (* IHn' is the Inductive Hypothesis. *)
  - reflexivity.
  - simpl. rewrite <- IHn'. (* note that the IHn' means n' = n' + 0 *)
    reflexivity.
Qed.

(* Another example *)
Theorem minus_diag : forall n,
    minus n n = 0.
Proof.
  intros n. induction n as [| n' IHn'].
  - reflexivity.
  - simpl. (* n' - n' = 0 *)
    rewrite -> IHn'. (* 0 = 0 *)
    reflexivity.
Qed.

(* again *)
Lemma plus_n_Sm : forall n m : nat,
    n + (S m) = S (n + m).
Proof.
  intros n m. induction n as [| n' IHn'].
  - reflexivity.
  - simpl. rewrite -> IHn'. reflexivity.
Qed.

(* Another again *)
(* Commutativity of Addition *)
(* Use the Lemma plus_n_Sm to refine the result. *)
Theorem plus_comm : forall n m : nat,
    n + m = m + n.
Proof.
  intros n m.
  induction n as [| n' IHn'].
  - simpl. rewrite <- plus_n_0_again. reflexivity.
  - simpl. rewrite -> IHn'.
    rewrite <- plus_n_Sm. reflexivity.
Qed.

(*------------------------------------------------------------------------------------------------------------------------------------------*)
(* large proofs are often broken into a sequence of theorems *)
(* However, sometimes a proof will require some miscellaneous fact that is too trivial
 and of too little general interest to bother giving it its own top-level name.*)
(* try assert tactic! *)
Theorem mult_0_plus' : forall n m : nat,
    (0 + n) * m = n * m.
Proof.
  intros n m.
  assert (H : 0 + n = n). { reflexivity. }
                          rewrite -> H.
  reflexivity.
Qed.

Theorem plus_rearrange : forall n m p q : nat,
    (n + m) + (p + q) = (m + n) + (p + q).
Proof.
  intros n m p q.
  rewrite -> plus_comm. (* in this way, coq may confused *)
  (* It result in n+m+(p+q) = m+n+(p+q) *)
  (* However, we want to swap just m+n to n+m *)
Abort.

Theorem plus_rearrange : forall n m p q : nat,
    (n + m) + (p + q) = (m + n) + (p + q).
Proof.
  intros n m p q.
  assert (n + m = m + n).
  { rewrite -> plus_comm. reflexivity. }
  rewrite -> H. reflexivity.
Qed.
