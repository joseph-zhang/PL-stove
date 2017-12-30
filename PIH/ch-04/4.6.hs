-- solution for ex. 4.6

mult :: (Num a) => a -> a -> a -> a
mult = \x -> \y -> \z -> (x * y * z)