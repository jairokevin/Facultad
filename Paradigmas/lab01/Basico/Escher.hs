module Basico.Escher where
import Dibujo
import Graphics.Gloss.Data.Picture
import Interp

data Bas = Dib 
         | Vacia
         
type Escher = Bas

ejemplo :: Dibujo Bas
ejemplo = escher 2 (Basica Dib)

interpBas :: Output Bas
interpBas Dib = trian2
interpBas Vacia = blanca

dibujo_u :: Dibujo Escher -> Dibujo Escher
dibujo_u p = Encimar (Encimar (dib1) (Rotar dib1)) 
                     (Encimar (r180 dib1) (r270 dib1)) 
    where dib1 = Espejar(Rot45 p) 
   
dibujo_t :: Dibujo Escher -> Dibujo Escher
dibujo_t p = Encimar (p) (Encimar (dib1) (dib2))
    where dib1 = Espejar(Rot45 p)
          dib2 = r270 dib1

lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 0 p = Basica Vacia
lado n p = cuarteto (lado(n-1) p) (lado(n-1) p) (Rotar(dibujo_t p)) (dibujo_t p)

esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina 0 p = Basica Vacia
esquina n p = cuarteto (esquina(n-1) p) (lado(n-1) p) (Rotar(lado(n-1) p)) (dibujo_u p)

noneto p q r s t u v w x = Apilar 2 1 (Juntar 2 1 p (Juntar 1 1 q r))        
                                      (Apilar 1 1 (Juntar 2 1 s (Juntar 1 1 t u))
                                                  (Juntar 2 1 v (Juntar 1 1 w x)))
                                                  
escher :: Int -> Dibujo Escher -> Dibujo Escher
escher n p = noneto (en) (ln) (r270 en)
                    (Rotar ln) (dibujo_u p) (r270 ln)
                     (Rotar en) (r180 ln) (r180 en)
  where en = esquina n p
        ln = lado n p
