-- This file give some examples of "guard"

max' :: (Ord a) => a -> a -> a
max' a b
    | a < b = b
    | otherwise = a

myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
    | a == b = EQ
    | a <= b = LT
    | otherwise = GT

