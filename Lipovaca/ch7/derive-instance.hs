-- this file will give some examples of instance deriving

-- we know that "deriving" can derive a type from typeclass,
-- recalling what we have implemented, derive type Person from typeclass Show and Eq.
data Person = Person{
  firstName :: String
, lastName :: String
, age :: Int
} deriving (Show, Eq)
-- In this way, we can compare the identity of two Person value  

-- give another example.
data Day = Monday | Tuesday | Wendnesday | Thursday | Friday | Saturday | Sunday
           deriving (Eq, Ord, Show, Read, Bounded, Enum)
{-
  > show Wednesday
  > "Wednesday"         -- Show typeclass behaviour
  > read "Saturday" :: Day 
  > Saturday            -- Read typeclass behaviour
  > Saturday == Sunday  
  > False               -- Eq typeclass behaviour
  > minBound :: Day
  > Monday              -- Bounded typeclass behaviour
  > succ Monday
  > Tuesday             -- Enum typeclass behaviour
-}