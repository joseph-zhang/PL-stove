-- an interactive program is viewed as a pure function that takes the current state of the world as its argument,
-- and produces a modified world as its result. Expressions of type IO a are called actions.
-- IO () is the type of actions that return the empty tuple () as a dummy result value.
-- The function return provides a bridge from pure expressions without side effects to impure actions with side effects.
-- an example

main :: IO ()
main = do putStr "Enter a string: "
          xs <- getLine
          putStr "The string has "
          putStr $ show $ length $ xs
          putStrLn " characters."
