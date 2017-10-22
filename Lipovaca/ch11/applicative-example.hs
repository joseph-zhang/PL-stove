-- this file will show some examples of Applicative Functor 
-- Applicative Funtor is an enhanced version of Functor, letting 
-- function in context process value in context.
-- Now that we have talked about this concept in syntax file, just give some examples.
-- Note that this file cannot be compiled correctly.

-- Maybe as applicative functor instance
pure "Hey" : Maybe String -- Just "Hey"
pure (+3) <*> Just 9  -- Just 12
Nothing <*> Just "asc"  -- Nothing
Just "woot" <*> Nothing  -- Nothing 

-- applicative style
-- pure f <*> x <*> y <*> ...
-- pure f <*> x equal to fmap f x, that is, f <$> x
pure (+) <*> just 3 <*> Just 5  -- Just 8 

-- list as applicative functor instance
pure "Hey" :: [String]  -- ["Hey"]
[(*0), (+100), (^2)] <*> [1 ,2, 3]  -- [0, 0, 0, 101, 102, 103, 1, 4, 9]
[(+), (*)] <*> [1, 2] <*> [3, 4] -- [(+1), (+2), (*1), (*2)] <*> [3, 4] = [4, 5, 5, 6, 3, 4, 6, 8]
(++) <$> ["ha", "heh", "hmm"] <*> ["?", "!"] -- ["ha?", "ha!", "heh?", "heh!"] 

-- IO as applicative functor instance 
myAction :: IO String
myAction = (++) <$> getLine <*> getLine

-- function as applicative functor instance
(pure 3) "blah"  -- 3
(+) <$> (+3) <*> (* 100) $ 5  -- 508
(\x y z -> [x, y, z]) <$> (+3) <*> (*2) <*> (/2) $ 5  -- [8.0, 10.0, 2.5]
