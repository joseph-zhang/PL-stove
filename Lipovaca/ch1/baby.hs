-- This file is for testing.
--simple expression examples
doubleMe x = x + x

doubleUs x y = x * 2 + y * 2

doubleSmallNumber x = if x > 100 then x else x*2

doubleSmallNumbr' x = (if x > 100 then x else x*2) + 1

-- a more serious form of function definition
addThree::Int->Int->Int->Int
addThree x y z = x+y+z

-- a simple example of filter
getUpper::[Char]->[Char]
getUpper st = [c|c <- st,c `elem` ['A'..'Z']]


