-- This file give some examples of "where" and "let"

-- a simple example to show the usage of "let"
-- Note that "let" can only be holded by one guard
cylinder :: Double -> Double -> Double
cylinder r h = 
    let sideArea = 2 * pi * h;
        topArea = pi * r ^ 2;
    in  sideArea + 2 * topArea

-- "let" can also combine with list comprehension
calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]