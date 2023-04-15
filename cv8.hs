myTake :: (Num t, Ord t) => t -> [a] -> [a]
myTake 0 _              = []
myTake _ []             = []
myTake n (x:xs) | n > 0 = x:myTake (n-1) xs
                | otherwise = error "n must be > 0"

myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile _ [] = []
myTakeWhile p (x:xs) | p x = x:myTakeWhile p xs
                     | otherwise = []

myZip::[a] -> [b] -> [(a, b)]
myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = (x,y):myZip xs ys

myZipWith::(a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f xs ys = map (uncurry f) (myZip xs ys)