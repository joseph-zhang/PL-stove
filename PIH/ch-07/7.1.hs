-- solution for ex. 7.1
-- basic operation of higher order function

proc :: [a] -> (a -> a) -> (a -> Bool) -> [a]
proc lst f p = (map f) . (filter p) $ lst 