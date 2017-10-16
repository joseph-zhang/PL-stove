-- This file will give some exaples of some useful moudule functions
import Data.List
import Data.Char
-- an example of "words", "group" in moudule Data.List
wordNums :: String -> [(String, Int)]
wordNums = map (\ws -> (head ws, length ws)) . group . sort . words  

-- an example of "any", "tails" and "isPrefixOf" in moudule Data.List
isIn :: (Eq a) => [a] -> [a] -> Bool
xx `isIn` yy = any (xx `isPrefixOf`) (tails yy)

-- an example of "ord", "chr" in Data.Char
-- a simple process of encode and decode of Caesar ciper
encode :: Int -> String -> String
encode offset msg  = map (chr . (+ offset) . ord) msg

decode :: Int -> String -> String
decode offset msg = encode (negate offset) msg
