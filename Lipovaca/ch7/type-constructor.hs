-- this file give some examples of type constructor
-- we will consider how to bring polymorphic in type definition

-- the first example is what we familiar with, "Maybe"
-- data Maybe a = Nothing | Just a
-- if we don't use this method, we must to write different version of Maybe
-- for example, 
data IntMaybe = INothing | IJust Int
data StringMaybe = SNothing | SJust String
data ShapeMaybe = ShNothing | ShJust Shape 
-- these definition tell us the importance to bring polymorphic in type definition.

-- Now we can consider what time should we use this method?
data Car a b c = Car { company :: a
                     , model :: b 
                     , year :: c
                     } deriving (Show)
-- this is not a god definition, because we have known about the type of value-parameters.
-- Actually, we can just define this as
data Car' = Car' { company :: String
                 , model :: String
                 , year :: Int
                 } deriving (Show)

-- now we implement an example, vector type.
data Vector a = Vector a a a deriving (Show)

vplus :: (Num a) => Vector a -> Vector a -> Vector a
(Vector x1 y1 z1) `vplus` (Vector x2 y2 z2) = Vector (x1+x2) (y1+y2) (z1+z2)

dotProd :: (Num a) => Vector a -> Vector a -> a
(Vector x1 y1 z1) `dotProd` (Vector x2 y2 z2) = x1*x2 + y1*y2 + z1*z2

