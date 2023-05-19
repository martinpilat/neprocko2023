import Data.Char (toUpper)

type Stav = Char
type Abeceda = Int
data Pohyb = L | R | N

data TS = TS {
    stav :: Stav,
    funkce :: (Stav, Abeceda) -> (Stav, Abeceda, Pohyb), 
    koncovy_stav :: Stav,
    paska :: ([Abeceda], [Abeceda]),
    rel_l :: Int,
    rel_p :: Int
}

data NTS = NTS {
    nstav :: Stav,
    nfunkce :: (Stav, Abeceda) -> [(Stav, Abeceda, Pohyb)], 
    nkoncovy_stav :: Stav,
    npaska :: ([Abeceda], [Abeceda]),
    nrel_l :: Int,
    nrel_p :: Int
}

fce ('A', 0) = [('B', 1, R), ('B', 2, R)]
fce ('B', 0) = [('A', 2, R)]
fce _ = undefined

plus ('A', 2) = ('B', 2, R)
plus ('B', 1) = ('B', 1, R)
plus ('B', 2) = ('C', 1, R)
plus ('C', 1) = ('C', 1, R)
plus ('C', 2) = ('D', 0, L)
plus ('D', 1) = ('E', 2, L)
plus ('E', 1) = ('E', 1, L)
plus ('E', 2) = ('F', 2, N)
plus _ = undefined

instance Show TS where 
    show ts = show (stav ts) ++ " | " ++ l_paska ++ r_paska where
        l_paska = show $ reverse $ take (rel_l ts) (fst (paska ts))
        r_paska = show $ take (rel_p ts) (snd (paska ts))

instance Show NTS where 
    show ts = show (nstav ts) ++ " | " ++ l_paska ++ r_paska where
        l_paska = show $ reverse $ take (nrel_l ts) (fst (npaska ts))
        r_paska = show $ take (nrel_p ts) (snd (npaska ts))

nstep::NTS -> [NTS]
nstep ts = do
    let s = nstav ts
    let f = nfunkce ts
    let (lp@(l:ls), h:pp@(p:ps)) = npaska ts
    let rl = nrel_l ts
    let rp = nrel_p ts
    (ns, nh, pohyb) <- f (s, h)
    case pohyb of 
        L -> return ts {nstav = ns, npaska = (ls, l:nh:pp), 
                 nrel_l = max 0 (rl - 1), nrel_p = rp + 1}
        R -> return ts {nstav = ns, npaska = (nh:lp, pp), 
                 nrel_p = max 1 (rp - 1), nrel_l = rl + 1}
        N -> return ts {nstav = ns, npaska = (lp, nh:pp)}

step ts = let 
        s = stav ts
        f = funkce ts
        (lp@(l:ls), h:pp@(p:ps)) = paska ts
        rl = rel_l ts
        rp = rel_p ts
        (ns, nh, pohyb) = f (s, h)
    in
        case pohyb of 
            L -> ts {stav = ns, paska = (ls, l:nh:pp), 
                    rel_l = max 0 (rl - 1), rel_p = rp + 1}
            R -> ts {stav = ns, paska = (nh:lp, pp), 
                    rel_p = max 1 (rp - 1), rel_l = rl + 1}
            N -> ts {stav = ns, paska = (lp, nh:pp)}

main = do
    interact $ map toUpper