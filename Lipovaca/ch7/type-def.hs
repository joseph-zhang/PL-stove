-- This file will show how to define our own type.

-- define a new type named "Shape",
-- it has two possible cases: Circle and Rectangle,
-- the right of "=" is value-constructor, that is , Circle and Rectangle.
data Shape = Circle Float Float Float | Rectangle Float Float Float deriving (Show)
{- 
  Note that value-constructor is also function.
    >:t Circle
    >Circle :: Float -> Float -> Float -> Shape
-}

-- we can write a process for our new type Shape
-- pattern matching method is used.
area : Shape -> Float
area (Circle _ _ r) = pi * r ^ 2
area (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)

-- if the fields of a value-constructor is long, we can use record-syntax method
data Person  = Person { firstName :: String
                      , lastName :: String
                      , age :: Int
                      , height :: Float
                      , phoneNumber :: String
                      , flavor :: String
                      } deriving (Show)
