--rowMaker1 :: Int -> Int
--rowMaker1 n k = [ n .. n+k-1 ] : rowMaker1 (n+k) k

--rowMaker2 :: Int -> Int
--rowMaker2 n k = [ n,n-1..n-k+1 ] : rowMaker2 (n-k) k

data Matrix a
