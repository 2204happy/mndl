data Cmplx = Cmplx {im :: Double, re :: Double}

cmplxAdd :: Cmplx -> Cmplx -> Cmplx
cmplxAdd c1 c2 = Cmplx i r
    where
        r = re c1 + re c2
        i = im c1 + im c2

cmplxMul :: Cmplx -> Cmplx -> Cmplx
cmplxMul c1 c2 = Cmplx i r
    where
        r = (re c1)*(re c2) - (im c1)*(im c2)
        i = (re c1)*(im c2) + (im c1)*(re c2)
 
cmplxPow :: Cmplx -> Int -> Cmplx 
cmplxPow c n
    | n == 0    = Cmplx 0 1
    | otherwise = (cmplxPow c (n-1)) `cmplxMul` c
    
cmplxAbs :: Cmplx -> Double
cmplxAbs c = sqrt ((re c)**2+(im c)**2)

mndl :: Cmplx -> Int -> Cmplx
mndl c i
    | i == 0    = c
    | otherwise = ((mndl c (i-1)) `cmplxPow` 2) `cmplxAdd` c
    
mndlChar :: Cmplx -> Char
mndlChar c
    | cmplxAbs (mndl c 30) < 1000   = 'O'
    | otherwise                     = ' '

mndlLine :: Double -> String
mndlLine i = (map mndlChar c) ++ "\n"
    where c = map (Cmplx i) [(-2),(-1.96875)..1]


mndlString :: String
mndlString = concat (map (mndlLine) [1,0.96875..(-1)])
       
main :: IO ()
main = do
    putStr mndlString

