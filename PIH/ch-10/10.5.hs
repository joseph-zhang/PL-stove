-- a simple solution for ex. 10.5
-- to define an adder, using sequence

adder :: IO ()
adder = do putStr "How many numbers? "
           x <- getnum
           xs <- sequence (replicate x getnum)
           putStrLn $ ("The total is "++) $ (show .sum) $ xs

getnum :: IO Int
getnum = do x <- getLine
            return  (read x :: Int)
            

