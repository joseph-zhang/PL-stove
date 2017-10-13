-- This file shows some basic examples of range
-- Note that this file can not be compiled correctly, you should test it in GHCi.

[1..20]  -- constant value
['a'..'z']  -- small letters
['K'..'Z'] -- big letters
[2,4..20] -- even constant sequence
[3,6..20] -- step increase sequence
take 10 (cycle [1,2,3]) -- first 10 elements of a cycling list
replicate 3 10 -- a more clear way to get replicate list

