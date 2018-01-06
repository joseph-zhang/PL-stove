-- solution for ex. 7.7
-- auxiliary function

unfold :: (t -> Bool) -> (t -> a) -> (t -> t) -> t -> [a]
unfold p h t x 
    | p x = []
    | otherwise = h x: unfold p h t (t x)

map' :: (a -> b) -> [a] -> [b]
map' f = unfold null (f . head) tail 

iterate' :: (a -> a) -> a -> [a]
iterate' f x = unfold (\x -> False) id f x