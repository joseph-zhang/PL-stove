-- here are some implementation of base conversion
-- to show the higher-order function methods

-- the first implementation, use iterate
type Bit = Int

bit2int :: [Bit] -> Int
bit2int bits = sum [w*b | (w,b) <- zip weights bits]
    where weights = iterate (*2) 1

-- another implementation, use fold method
bit2int' :: [Bit] -> Int
bit2int' = foldr (\x y -> x + 2*y) 0

int2bit :: Int -> [Bit]
int2bit 0 = []
int2bit n = n `mod` 2 : int2bit (n `div` 2)

