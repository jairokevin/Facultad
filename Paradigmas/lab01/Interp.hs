module Interp where
import Graphics.Gloss
import Graphics.Gloss.Data.Vector
import Graphics.Gloss.Geometry.Angle
import Graphics.Gloss.Data.Picture
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

import Dibujo
type FloatingPic = Vector -> Vector -> Vector -> Picture
type Output a = a -> FloatingPic

-- el vector nulo
zero :: Vector
zero = (0,0)

half :: Vector -> Vector
half = (0.5 V.*)

sum_vector :: Vector -> Vector -> Vector
sum_vector a b = (a V.+ b) 

res_vector :: Vector -> Vector -> Vector
res_vector a b = (a V.- b)

vector_opuesto :: Vector -> Vector
vector_opuesto a = (zero V.- a)

-- comprender esta función es un buen ejericio.
hlines :: Vector -> Float -> Float -> [Picture]
hlines v@(x,y) mag sep = map (hline . (*sep)) [0..]
  where hline h = line [(x,y+h),(x+mag,y+h)] 

-- Una grilla de n líneas, comenzando en v con una separación de sep y
-- una longitud de l (usamos composición para no aplicar este
-- argumento)
grid :: Int -> Vector -> Float -> Float -> Picture
grid n v sep l = pictures [ls,translate 0 (l*toEnum n) (rotate 90 ls)]
  where ls = pictures $ take (n+1) $ hlines v sep l

-- figuras adaptables comunes
trian1 :: FloatingPic
trian1 a b c = line $ map (a V.+) [zero, half b V.+ c , b , zero]

trian2 :: FloatingPic
trian2 a b c = line $ map (a V.+) [zero, c, b,zero]

trianD :: FloatingPic
trianD a b c = line $ map (a V.+) [c, half b , b V.+ c , c]

rectan :: FloatingPic
rectan a b c = line [a, a V.+ b, a V.+ b V.+ c, a V.+ c,a]

simple :: Picture -> FloatingPic
simple p _ _ _ = p

blanca :: FloatingPic
blanca a b c = blank

fShape :: FloatingPic
fShape a b c = line . map (a V.+) $ [ zero,uX, p13, p33, p33 V.+ uY , p13 V.+ uY 
                 , uX V.+ 4 V.* uY ,uX V.+ 5 V.* uY, x4 V.+ y5
                 , x4 V.+ 6 V.* uY, 6 V.* uY, zero]    
  where p33 = 3 V.* (uX V.+ uY)
        p13 = uX V.+ 3 V.* uY
        x4 = 4 V.* uX
        y5 = 5 V.* uY
        uX = (1/6) V.* b
        uY = (1/6) V.* c

-- Dada una función que produce una figura a partir de un a y un vector
-- producimos una figura flotante aplicando las transformaciones
-- necesarias. Útil si queremos usar figuras que vienen de archivos bmp.

transf :: (a -> Vector -> Picture) -> a -> Vector -> FloatingPic
transf f d (xs,ys) a b c  = translate (fst a') (snd a') .
                             scale (magV b/xs) (magV c/ys) .
                             rotate ang $ f d (xs,ys)
  where ang = radToDeg $ argV b
        a' = a V.+ half (b V.+ c)
        
rotar :: FloatingPic -> FloatingPic
rotar f a b c = f (sum_vector a b) c (vector_opuesto b)

rotar45 :: FloatingPic -> FloatingPic
rotar45 f a b c = f (sum_vector a (half (sum_vector b c))) 
                    (half (sum_vector b c)) (half (res_vector c b))
 
espejar :: FloatingPic -> FloatingPic
espejar f a b c = f (sum_vector a b) (vector_opuesto b) c

mulVec :: Float -> Vector -> Vector
mulVec x v2 = x V.* v2 

juntar ::  Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
juntar n m p q a b c =  pictures [p a b' c, q (sum_vector a b') (r' V.* b) c]
  where r' =  n/(m+n)
        r =  m/(m+n)  
        b' = r V.* b
        
apilar :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
apilar n m p q a b c = pictures [p (sum_vector a c1) b (r V.* c), q a b c1]
       where r'= n/(m+n)
             r = m/(m+n)
             c1= r' V.* c

encimar :: FloatingPic -> FloatingPic -> FloatingPic
encimar p q a b c = pictures [p a b c, q a b c]

interp :: Output a -> Output (Dibujo a)
interp f (Basica a) = f (a)
interp f (Rotar d) = rotar $ interp f d
interp f (Rot45 d) = rotar45 $ interp f d
interp f (Espejar d) = espejar $ interp f d
interp f (Juntar n m d d') = juntar (toEnum n :: Float) (toEnum m :: Float) (interp f d) (interp f d')
interp f (Apilar n m d d') = apilar (toEnum n :: Float) (toEnum m :: Float) (interp f d) (interp f d') 
interp f (Encimar d d') = encimar (interp f d) (interp f d')
