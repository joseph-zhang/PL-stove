-- this file will give some exampls of typeclass definition,
-- and the methods to manually implement instantiation.

-- now we can see this type, traffic-light.
data TrafficLight = Red | Yellow | Green
-- we can find that this type should be the instance of typeclass Eq
-- now we give this type a instantiation:
instance Eq TrafficLight where
    Red == Red = True
    Green == Green = True
    Yellow == Yellow = True
    _ == _ = False
-- which is equal to "deriving (Eq)" for this type.

{- 
  Recalling that a typeclass will define some interfaces of behaviour.
  Actually, the type class Eq give the method of minimal complete, 
  thus we just need to implement the "==" behaviour for our type TrafficLight.
  class Eq a where
      (==) :: a -> a -> Bool
      (/=) :: a -> a -> Bool
      x == y = not (x /= y)
      x /= y = not (x == y)
  the interface part is the first two lines in where block. 	  
-}

-- now we can give this type another instantiation:
instance Show TrafficLight where
    show Red = "Red light"
    show Yellow = "Yellow light"
    show Green = "Green light"
-- note that if we use deriving to give instantiation, 
-- we can only get the string which convert from the name of value constructor.

-- now we should pay attention to a fact,
-- a typeclass can be sub-typeclass of another one.
-- This means, if typeclass A is the sub~ of another typeclass B,
-- the instance of A must be instance of typeclass B.
-- This can be implemented by using type constraint.
-- for example "class (Eq a) => Num a where ..."

-- now we will consider how to give instantiation to type-constructor.
-- the parameters of type-constructor is specific type, we should use polymorphic here.
instance (Eq m) => Eq (Maybe' m) where
    Just' x == Just' y = x == y
    Nothing' == Nothing' = True
    _ == _ = False
-- the type constructor Mybe' is our own version of Maybe 
data Maybe' a = Nothing' | Just' a deriving (Show)	