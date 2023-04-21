import Data.Char (toUpper)

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f acc []     = acc
myFoldl f acc (x:xs) = myFoldl f (f acc x) xs

myFoldr :: (b -> a -> a) -> a -> [b] -> a
myFoldr f init []     = init
myFoldr f init (x:xs) = f x (myFoldr f init xs)

myFoldr2 f init = g
    where
        g []     = init
        g (x:xs) = f x (g xs)


myMap f [] = []
myMap f (x:xs) = f x:myMap f xs

mapFoldr f = foldr (\x acc -> f x: acc) []

naVelka::String -> String
naVelka = map toUpper

horner2 :: [Integer] -> Integer
horner2 = foldl (\acc x -> 10*acc + x) 0

fibs = 0:1:(zipWith (+) fibs (tail fibs))