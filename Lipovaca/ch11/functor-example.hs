-- this file will show some examples about Functor
-- Functors can be thought of as homomorphisms between categories
-- 函子(Functor)是范畴间的同态
-- Now that we have talked about this concept in syntax file, just give some examples.
-- Note that this file cannot be compiled correctly.

-- list as instance of Functor 
res = fmap (*2) [1..3]  -- [2,4,6]
-- the function map as specialization
res = map (*2) [1..3]  -- [2,4,6]

-- Maybe as instance of Functor 
res = fmap (*2) (Just 200)  -- Just 400
res = fmap (*2) Nothing  --  Nothing
res = fmap (++ "Hey! look here!") Nothing  -- Nothing

-- Tree as instance of Functor
res = fmap (*2) EmptyTree  -- EmptyTree
res = fmap (*4) (foldr treeInsert EmptyTree [5,7,3])  -- a new tree, node val multi 4

-- IO as instance of Functor
main = do 
  line <- fmap reverse getLine
  putStrLn $ "You said " ++ line ++ "backwards!"  

-- function as instance of Functor
res = fmap (*3) (+100) 1  -- 303
-- same as 
res = (*3) `fmap` (+100) $ 1  -- 303

-- an example violates Functor law
data CMaybe = CNothing | CJust Int a deriving (Show)
-- if we don't check Functor law and do instantiation
instance Functor CMaybe where
  fmap f CNothing = CNothing
  fmap f (CJust counter x) = CJust (counter + 1) (f x)
{-
  it violates Functor law:
  check law 1:
  > fmap id (CJust 0 "csa")
  > CJust 1 "csa"
  > id (CJust 0 "csa")
  > CJust 0 "csa"
  
  Do not obey law 1!
-}

