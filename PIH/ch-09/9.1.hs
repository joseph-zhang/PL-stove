-- solution for ex. 9.1
-- redefine the function choices using a list comprehension

choices xs = [zd | ys <- subs xs, zs <- perms ys]

-- permutations of a lists
perms :: [a] -> [[a]]
perms []     = [[]]
perms (x:xs) = concat $ (map (interleave x)) $ perms $ xs

-- subSequences of a list
subs :: [a] -> [[a]]
subs []     = [[]]
subs (x:xs) = yss ++ map (x:) yss
              where yss = subs xs
