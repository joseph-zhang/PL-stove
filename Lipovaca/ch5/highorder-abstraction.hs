-- This file will give some examples of high order functions.

-- a function apply on itself
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

-- zipWith in Haskell just like "map" in lisp, it can be seen as advanced "map"
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = (f x y):(zipWith' f xs ys)
 
-- flip 
flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f x y = f y x

-- map in Haskell 
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = (f x) : (map' f xs)

-- filter abstraction
filter' :: (a -> Bool) -> [a] -> [b]
filter' _ [] = []
filter' f (x:xs) = 
    | (f x) = x : (filter' f xs)
    | otherwise = filter' f xs	

{- 
  We have introduced some high order abstraction.
  zipWith, map and filter are most important among them.
  to mapping a function of multiple parameters, just use Currying method to consider it.
-}
