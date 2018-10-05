Require Export polymorphism.
(* coq treats function as First-Class Citizens, allowing them to be passed as arguments to other functions,
returned as results, stored in data structures, etc.*)

(* A simpl example, f will be applied three times on value n *)
Definition doit3times {X : Type} (f : X -> X) (n : X) : X :=
  f (f (f n)).

Check @doit3times. (* ===> @doit3times : forall X : Type, (X -> X) -> X -> X *)

(*-------------------------------------------------------------------------------------------------------------------------------------------*)
(* Useful functional methods *)
(* Filter *)
Fixpoint filter {X} (f : X -> bool) l : list X :=
  match l with
  | [] => []
  | a :: l' => if f a then a :: (filter f l')
              else filter f l'
  end.

(* Map *)
Fixpoint map {X Y} f (l : list X) : list Y :=
  match l with
  | [] => []
  | a :: l' => (f a) :: (map f l')
  end.

(* Fold *)
Fixpoint fold {X Y} f (l : list X) (b : Y) : Y :=
  match l with
  | [] => b
  | a :: l' => f a (fold f l' b)
  end.

(* Anonymous Functions *)
(* first we define some auxiliary functions *)
Fixpoint beq_nat (n m : nat) : bool :=
  match n with
  | 0 => match m with
        | 0 => true
        | _ => false
        end
  | S n' => match m with
           | 0 => false
           | S m' => beq_nat n' m'
           end
  end.

Definition length_is_1 {X} (l : list X) : bool :=
  beq_nat (length l) 1.

(* write a test for filter *)
Example test_filter2:
    filter length_is_1
           [ [1; 2]; [3]; [4]; [5;6;7]; []; [8] ]
    = [ [3]; [4]; [8] ].
Proof. reflexivity. Qed.

(* the function length_is_1 is just One-off, a better method: *)
Example test_filter2':
    filter (fun l => beq_nat (length l) 1)
           [ [1; 2]; [3]; [4]; [5;6;7]; []; [8] ]
  = [ [3]; [4]; [8] ].
Proof. reflexivity. Qed.
