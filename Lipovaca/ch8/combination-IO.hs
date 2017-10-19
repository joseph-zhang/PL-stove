-- this file will give an example of combinition I/O.
-- use "do" to combine a few I/O actions.
import Data.Char

main = do
    putStrLn "Hello, what's your name?" -- output action
    name <- getLine -- binding, input action
    putStrLn ("Hey " ++ name ++ " !") 
    putStrLn $ "Welcome " ++ name ++ " !"
    -- I/O action is not pure
    -- we use let and binding for pure value and I/O action respectively
    putStrLn "and.. what's your last name?" 
    lastName <- getLine
    let bigName = map toUpper name
        bigLastName = map toUpper lastName
    putStrLn $ "get, " ++ bigName ++ " " ++ bigLastName