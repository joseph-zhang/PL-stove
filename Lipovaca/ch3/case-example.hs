-- This file give some examples of "case"

-- a simple example of "case"
-- actually, the pattern matching in function definition is just syntactic sugar of "case" expr.
-- we can compare it with the previous definition of head.
{-
head' :: [a] -> a
head' [] = error "No head for empty lists!"
-}

head' :: [a] -> a
head' xs = case xs of [] -> error "No head for empty lists!"
                      (x:_) -> x
					  
-- "case" expression can used in any expr, not just for function define.
describeList :: [a] -> String
describeList ls = "The list is " ++ case ls of [] -> "empty"
                                               [x] -> "a singleton list"
                                               xs -> "a long list";

-- this can also be implemented by using "where"
describeList' :: [a] -> String
describeList' ls = "The list is " ++ what ls
    where what [] = "empty";
          what [x] = "a singleton list";
		  what xs = "a long list";