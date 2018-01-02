-- solution for ex. 5.3
-- to find the right angled triangle
pyths :: Int -> [(Int,Int,Int)]
pyths n = [(a,b,c) | c <- [1..n], a <- [1..c], b <- [1..c],
                     a^2 +b^2 == c^2]