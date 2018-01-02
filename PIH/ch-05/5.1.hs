-- solution for ex. 5.1
-- to calculate the summation 1^2 + 2^2 + ... + 100^2
res = sum [x^2 | x <- [1..100]]