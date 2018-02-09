-- solution for ex. 9.2
-- define a function isChoice to decide if one list is chosen from another

isChoice :: Eq a => [a] -> [a] -> Bool
isChoice [] _      = True
isChoice (x:xs) [] = False
isChoice (x:xs) ys = x `elem` ys && isChoice xs (removefirst x ys)

removefirst :: Eq a => a -> [a] -> [a]
removefirst x [] = []
removefirst x (y:ys)
  | x == y = ys
  | otherwise = y : (removefirst x ys)
