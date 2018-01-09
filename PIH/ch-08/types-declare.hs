-- the notion of type, newtype and data is important
-- this related to algebraic data type notion 

-- type can be used to define alias
-- data can be used to define a completely new type
-- newtype can be used to modify an existing type

-- type declare
type Pair a  = (a,a)
type Pos = (Int, Int)
type Assoc k v = [(k,v)]

find :: (Eq k) => k -> Assoc k v -> v
find k t = head [v | (k',v) <- t, k == k']

-- data declare
data Move = North | South | East | West deriving (Show,Eq)

move :: Move -> Pos -> Pos 
move North (x,y) = (x,y + 1)
move South (x,y) = (x,y - 1)
move East  (x,y) = (x + 1,y)
move West  (x,y) = (x - 1,y)

rev :: Move -> Move
rev North = South
rev South = North
rev East = West
rev West = East

moves :: [Move] -> Pos -> Pos
moves t pos = foldl (flip move) pos t

-- newtype declare
newtype Nata = N Int 

-- use data to define recursive data type
data Nat = Zero | Succ Nat

nat2int :: Nat -> Int
nat2int Zero = 0
nat2int (Succ n) = 1 + nat2int n

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat n = Succ (int2nat (n-1))

add :: Nat -> Nat -> Nat
add Zero n = n
add (Succ m) n = Succ (add m n)

data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving (Show,Eq)

occurs :: Eq a => a -> Tree a -> Bool
occurs x (Leaf v) = x == v
occurs x (Node l v r) = x == v || occurs x l || occurs x r

flatten :: Tree a -> [a]
flatten (Leaf v) = [v]
flatten (Node l v r) = flatten l ++ [v] ++ flatten r

----------------------- test code -----------------------
t :: Tree Int
t = Node (Node (Leaf 1) 3 (Leaf 4)) 5 
         (Node (Leaf 6) 7 (Leaf 9))
