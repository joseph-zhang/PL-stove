-- this file will show some examples about Zip-List
-- we have talked about a method to realize <*> about list structure,
-- this time we will talk about another method to give it a instance implementation.

{-
  for normal list structure: [(+3), (*2)] <*> [1, 2]
  result: [4, 5, 2, 4]
 
  another method to give list a instantiation is apply corresponding position value.
  [4, 4]
-}
-- ZipList in Control.Applicative
newtype ZipList a = ZipList {getZipList :: [a]}
-- it is a instance of Applicative 
instance Applicative ZipList where
  pure x = ZipList (repeat x)  -- you should understand why we use infinite list
  ZipList fs <*> ZipList xs = ZipList (zipWith (\f x -> f x) fs xs)

-- show how to use it 
res = getZipList $ (+) <$> ZipList [1,2,3] <*> ZipList [100,100,100]  -- [101, 102, 103]


-- note that the standard library included some similar function like zipWith
-- zipWith3, zipWith4, ..., zipWith7   

