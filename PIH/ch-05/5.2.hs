-- solution for ex. 5.2
-- implement replicate function by using list comprehension
replicate' :: Int -> a -> [a]
replicate' n x = [x | _ <- [1..n]]