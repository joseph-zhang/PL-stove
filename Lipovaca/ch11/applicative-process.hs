-- his file will sow some usefule Applicative functions/processes

-- interesting one : liftA2
-- from the name "liftA2" we can know that this function will lift a normal function. 
liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c
liftA2 f a b = f <$> a <*> b
{-
  to consider it as (a -> b -> c) -> (f a -> f b -> f c)
  we can see that this function lift a normal function, 
  let it has ability to process between two Applicative values. 
-}

res = liftA2 (:) (Just 3) (Just [4])  -- [3,4]
res = (:) <$> Just 3 <*> Just 4  -- [3,4]

-- Another function is sequenceA
-- the definition use recursive method
sequenceA :: (Applicative f) => [f a] -> f [a]
sequenceA [] = pure []  -- basement 
sequenceA (x:xs) = (:) <$> x <*> sequenceA xs 

-- to see some examples: 
res = sequenceA [Just 3, Just 2, Just 1]  -- Just [3,2,1]
res = sequenceA [[1,2,3], [4,5,6]]  -- [[1,4], [1,5], [1,6], [2,4], [2,5], [2,6], [3,4], [3,5], [3,6]]
{-
  consider this pattern (:) <$> a <*> b, we know that it is liftA2 (:) a b
  Thus, sequenceA can be defined as:
    sequenceA :: (Applicative f) => [f a] -> f [a]
    sequenceA = foldr (liftA2 (:)) (pure [])
-}
