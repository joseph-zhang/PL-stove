-- a simple solution for ex. 10.4
-- to define an adder, simple IO action

adder :: IO ()
adder = do putStr "How many numbers? "
           x <- getnum
           res <- adhelper 0 x
           putStrLn $ ("The total is "++) $ show $ res

getnum :: IO Int
getnum = do x <- getLine
            return (read x :: Int)

putLine :: IO ()
putLine = putChar '\n'
  
adhelper :: Int -> Int -> IO Int
adhelper total 0 = return total
adhelper total remains = do x <- getnum
                            adhelper (total + x) (remains - 1)
