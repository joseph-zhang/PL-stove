-- the solution for ex. 8.1
-- the recursive type of natural numbers Nat
data Nat = Zero | Succ Nat

-- addition of Nat
add :: Nat -> Nat -> Nat
add Zero n = n
add (Succ m) n = Succ (add m n)

-- multipication of Nat 
mult :: Nat -> Nat -> Nat
mult _ Zero = Zero
mult Zero _ = Zero 
mult m (Succ n) = add m (mult m n)
