-- solution for ex. 4.2
-- three styles of function safetail

-- (a) conditional expression
safetail :: [a] -> [a]
safetail lst = if null lst
               then []
               else  tail lst

-- (b) guarded equations
safetail' :: [a] -> [a]
safetail' lst
    | null lst = []
    | otherwise = tail lst


-- (c)  pattern matching
safetail'' :: [a] -> [a]
safetail'' [] = []
safetail'' (x:xs) = xs