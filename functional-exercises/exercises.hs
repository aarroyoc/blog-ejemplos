existe :: (Eq a) => [a] -> a -> Bool
existe lis e = foldr1 (\x y -> x || y) $ map (\x -> x == e) lis

dignum :: [Int] -> Int
dignum ds = let
  dig_len = length ds
  powers = [(dig_len-1),(dig_len-2)..0]
  in
  foldr1 (+) $ map (\(x,y) -> x * 10^y) $ zip ds powers

maxlis :: (Ord a) => [a] -> a
maxlis = foldr1 (\x y -> if x > y then x else y)

contar :: (Eq a) => a -> [a] -> Int
contar e xs = length $ filter (\x -> x == e) xs

contar' :: (Eq a) => a -> [a] -> Int
contar' e xs = foldr1 (+) $ map (\x -> if x == e then 1 else 0) xs

dividePares :: [Int] -> [Int]
dividePares xs = map (\x -> x `div` 2) $ filter (\x -> x `mod` 2 == 0) xs

enRango :: Int -> Int -> [Int] -> [Int]
enRango mi ma = filter enRango' 
    where
      enRango' x = x >= mi && x <= ma

mayor :: (Ord a) => [a] -> a -> [a]
mayor ls e = filter (\x -> x > e) ls 

cuentaPositivos :: [Int] -> Int
cuentaPositivos xs = length $ mayor xs 0
