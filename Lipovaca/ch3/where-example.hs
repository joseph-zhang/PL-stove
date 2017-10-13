-- This file give some examples of "where" and "let"

-- a simple example to show the usage of "where"
-- Note that the action scope of "where" is only its corresponding pattern
bmiTell :: Double -> Double -> String
bmiTell weight height 
    | bmi <= skinny = "underweight!"
    | bmi <= normal = "normal~"
    | bmi <= fat = "a little fat~"
    | otherwise = "fat!"
    where bmi = weight / height ^ 2
          skinny = 18.5
          normal = 25.0
          fat = 30.0

-- we can also use pattern matching in "where"
initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ ". "
    where (f:_) = firstname
          (l:_) = lastname	

-- the "where" block can be also used to define function
-- in this function, we use not only pattern matching but also function definition 
calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi w h | (w, h) <- xs]
    where bmi weight height = weight / height ^ 2
 