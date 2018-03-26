module MonadExample
( Tree(Leaf,Node)
, getchars
, pairs
) where
                   

{- Functor Example -}
data Tree a = Leaf a | Node (Tree a) (Tree a) deriving Show

instance Functor Tree where
  -- fmap :: (a -> b) -> Tree a -> Tree b
  fmap g (Leaf x)   = Leaf (g x)
  fmap g (Node l r) = Node (fmap g l) (fmap g r)


{- Applicative Example -}
getchars :: Int -> IO String
getchars n = sequenceA (replicate n getChar)


{- Monad Example -}
pairs :: [a] -> [b] -> [(a, b)]
pairs xs ys = do x <- xs
                 y <- ys
                 return (x, y)
