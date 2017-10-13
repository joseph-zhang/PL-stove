-- This file will show some basic examples of tuple

ex1 = (3,'a',"hello") -- this means a tuple can be mixed
:t ex1 -- the result is: ex1:: (Num a) => (a, Char, [Char])

-- if the length of a tuple is two, we called it "pair"
pair1 = (8,11)
:t pair1 -- the result is: pair1:: (Num a, Num b) => (a, b)
-- pair has many useful relative processes
fst pair1 -- result: 8
snd pair1 -- result: 11

-- the process "zip" can be used to construct a list of pairs 
zip [1,2,3,4,5] ['a','b','c','d','e'] -- result: [(1,'a'), (2,'b'), (3,'c'), (4,'d'), (5,'e')]

