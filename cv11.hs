{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}

class MujMonoid a where
    binarni :: a -> a -> a
    nic :: a

data Seznam a = Cons a (Seznam a) | Nil deriving (Show, Read)

spoj::Seznam a -> Seznam a -> Seznam a
spoj Nil x         = x
spoj (Cons x xs) y = Cons x (spoj xs y)

instance MujMonoid (Seznam a) where
    binarni xs ys = spoj xs ys
    nic = Nil

instance MujMonoid [a] where 
    binarni xs ys = xs ++ ys
    nic = []

instance MujMonoid Int where
    binarni xs ys = xs + ys
    nic = 0

class MujMonoid2 a where 
    bin :: a -> a -> a
    prazdny :: a

instance MujMonoid2 Int where
    bin xs ys = xs * ys
    prazdny = 1

pospojuj :: MujMonoid m => [m] -> m
pospojuj [] = nic
pospojuj xs = foldl binarni nic xs

pospojuj2 :: MujMonoid2 m => [m] -> m
pospojuj2 [] = prazdny
pospojuj2 xs = foldl bin prazdny xs

instance Semigroup (Seznam a) where 
    (<>) = spoj

instance Monoid (Seznam a) where 
    mempty = Nil

instance Num a => (MujMonoid a) where
    binarni = (+)
    nic = 0

data Mozna a = Proste a | Nic deriving (Show)

safeLog x | x <= 0 = Nic
          | otherwise = Proste (log x)

safeSqrt x | x < 0 = Nic
           | otherwise = Proste (sqrt x)

slozeni::(b -> Mozna c)->(a -> Mozna b)->(a -> Mozna c)
slozeni g f x = gaaaag (f x) where
                    gaaaag Nic = Nic
                    gaaaag (Proste a) = g a

qsort [] = []
qsort (x:xs) = qsort mensi ++ x:qsort vetsi 
                where
                    mensi = [y | y <- xs, y < x]
                    vetsi = [y | y <- xs, y >= x]