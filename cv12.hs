import Data.Char (toUpper)

data Mozna a = Proste a | Nic deriving (Show)

safeLog x | x <= 0 = Nic
          | otherwise = Proste (log x)

safeSqrt x | x < 0 = Nic
           | otherwise = Proste (sqrt x)

-- (safeLog 0) `potom` safeSqrt == Nic
-- (safeLog 0.1) `potom` safeSqrt == Nic 
-- (safeLog 10) `potom` safeSqrt == Proste (sqrt (log 10))
potom::Mozna a -> (a -> Mozna b) -> Mozna b
potom Nic _ = Nic
potom (Proste x) f = f x

mSafeLog x | x <= 0 = Nothing
           | otherwise = Just (log x)

mSafeSqrt x | x < 0 = Nothing
            | otherwise = Just (sqrt x)

mSafeSqrtLog x1 x2 = do
    y <- mSafeLog x1 
    z <- mSafeLog x2
    mSafeSqrt (y + z)

instance Functor Mozna where
    --fmap::(a->b) -> Mozna a -> Mozna b 
    fmap f Nic = Nic
    fmap f (Proste a) = Proste (f a)

instance Applicative Mozna where 
    --pure:: a -> Mozna a
    pure x = Proste x
    --(<*>):: Mozna (a -> b) -> Mozna a -> Mozna b
    Nic <*> _ = Nic
    (Proste f) <*> x = fmap f x

plus3 x y z = x + y + z

instance Monad Mozna where
    --(>>=)::Mozna a -> (a -> Mozna b) -> Mozna b
    (>>=) = potom
    --return = pure

safeSqrtLog x1 x2 = do
    y <- safeLog x1 
    z <- safeLog x2
    return (y + z)

usporadaneDvojice xs ys = do
    x <- xs
    y <- ys
    return (x+y)

zakric :: IO ()
zakric = do
    x <- getLine
    let y = map toUpper x
    putStrLn y
