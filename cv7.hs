fac :: Integer -> Integer
fac 1 = 1
fac n = n * fac (n-1)

fac2 n | n > 0     = n * fac2 (n-1)
       | otherwise = 1

plus1 :: Num a => a -> a
plus1 x = x + 1

myMap :: (t -> a) -> [t] -> [a]
myMap f [] = []
myMap f (x:xs) = f x:myMap f xs

plus1kSeznamu :: Num a => [a] -> [a]
plus1kSeznamu = myMap plus1

myFilter p [] = []
myFilter p (x:xs) | p x = x:myFilter p xs
                  | otherwise = myFilter p xs