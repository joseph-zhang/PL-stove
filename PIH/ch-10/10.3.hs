-- solution for ex. 10.3
putBoard b = sequence_ [putRow r n | (r,n) <- zip [1..] b]
