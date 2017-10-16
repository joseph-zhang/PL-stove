-- This file will give some examples of association list
import qualified Data.Map as Map
import Data.List
-- an association list can be expressed as a list of pairs
phoneBook = [ ("betty", "555-2938")
             ,("bonnie", "452-2928")
			 ,("pastsy", "493-2928")
            ]
-- simple process to indexing, this is included in Data.List, named "lookup"
findKey :: (Eq key) => key -> [(key, val)] -> val
findKey key xs = snd . head . filter (\(k, v) -> key == k) $ xs

-- to prevent empty list, we write it as a more safe version
findKey' :: (Eq key) => key -> [(key, val)] -> Maybe val
findKey' key [] = Nothing
findKey' key ((k, v):xs)  
    | key == k = Just v 
    | otherwise = findKey' key xs -- a 

-- map can also represent a kind of structure, it is more efficient than association list
-- we can use fromList to construct a map, input is an association list
-- there are some useful process in Data.Map can act on map structure: {size, insert, map...}
phoneMap :: Map.Map String String
phoneMap = Map.fromList phoneBook

-- to deal with the repeated key, we can use another method named fromListWith
phoneBookToMap :: (Ord k) => [(k, String)] -> Map.Map k String 
phoneBookToMap xs = Map.fromListWith add xs 
    where add number1 number2 = number1 ++ ", " ++ number2 

