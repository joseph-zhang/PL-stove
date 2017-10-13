-- This file will show some basic examples of list comprehension
-- Note that this file can not be compiled correctly, you should test it in GHCi.

[x*2 | x <- [1..10]] -- equal to 2 product a list
[x*2 | x <- [1..10], x*2 >= 12] -- add a predicate
[x | x <- [50.. 100], x 'mod' 7 == 3]
-- multiple predicate
[x | x <- [10..20], x /= 13, x /= 15, x /= 19]
-- nested list 
xxs = [[1,3,5,2,3,1,2,4,5], [1,2,3,4,5,6,7,8,9], [1,2,4,2,1,6,3,1,3,2,3,6]]
[ [x | x<- xs, even x] | xs <- xxs]
