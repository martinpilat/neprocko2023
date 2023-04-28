data Barva = Cervena | Zelena | Modra deriving (Show)

barvaNaRGB::Barva -> (Int, Int, Int)
barvaNaRGB Cervena = (225, 0, 0)
barvaNaRGB Zelena = (0, 255, 0)
barvaNaRGB Modra = (0, 0, 255)

data BarvaRGB = CervenaRGB | ZelenaRGB | ModraRGB |
                RGB Int Int Int deriving (Show)

rgbNaBarvaRGB::Int -> Int -> Int -> BarvaRGB
rgbNaBarvaRGB 255 0 0 = CervenaRGB
rgbNaBarvaRGB r g b = RGB r g b

barvaRGBnaRGB::BarvaRGB -> (Int, Int, Int)
barvaRGBnaRGB CervenaRGB = (255, 0, 0)
barvaRGBnaRGB ZelenaRGB = (0, 255, 0)
barvaRGBnaRGB ModraRGB = (0, 0, 255)
barvaRGBnaRGB (RGB r g b) = (r, g, b)

data Obrazec = Kruh Int Int Int | Ctverec Int Int Int Int 
               deriving (Show)

data Strom a = Nil | Uzel (Strom a) a (Strom a) 
               deriving (Show)

-- pridejBVS x strom = pridava x do stromu strom
pridejBVS::Ord a => a -> Strom a -> Strom a
pridejBVS x Nil = Uzel Nil x Nil
pridejBVS x uzel@(Uzel lp h pp) | x <= h    = Uzel (pridejBVS x lp) h pp
                                | otherwise = Uzel lp h (pridejBVS x pp)
                                

seznamNaStrom::Ord a => [a] -> Strom a
seznamNaStrom = foldr pridejBVS Nil

data Seznam a = SNil | Cons a (Seznam a)

foldrSeznam fCons fSNil = g
    where g SNil        = fSNil
          g (Cons x xs) = fCons x (g xs)

soucetStromu::Num a => Strom a -> a
soucetStromu Nil = 0
soucetStromu (Uzel lp h pp) = soucetStromu lp + h + soucetStromu pp

spojStrom::Strom String -> String
spojStrom Nil = ""
spojStrom (Uzel lp h pp) = spojStrom lp ++ h ++ spojStrom pp

foldStrom::a -> (a -> b -> a -> a) -> Strom b -> a
foldStrom fNil fUzel Nil = fNil
foldStrom fNil fUzel (Uzel lp h pp) = fUzel (foldStrom fNil fUzel lp) h (foldStrom fNil fUzel pp)

foldStrom2 fNil fUzel = g
    where 
            g Nil            = fNil
            g (Uzel lp h pp) = fUzel (g lp) h (g pp)
            