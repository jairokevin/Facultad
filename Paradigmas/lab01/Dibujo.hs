module Dibujo where

-- definir el lenguaje

type Pred a = a -> Bool

data Dibujo a = Basica a
    | Rotar (Dibujo a)
    | Espejar (Dibujo a) 
    | Rot45 (Dibujo a)
    | Apilar Int Int (Dibujo a) (Dibujo a)
    | Juntar Int Int (Dibujo a) (Dibujo a) 
    | Encimar (Dibujo a) (Dibujo a)
    deriving Show


-- x es un dibujo
comp :: (a -> a) -> Int -> a -> a
comp f n x = if n==0 then x else comp f (n-1) (f x)

r180 :: Dibujo a -> Dibujo a
r180 a = comp Rotar 2 a

r270 :: Dibujo a -> Dibujo a
r270 a = comp Rotar 3 a

(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) a b = Apilar 1 1 a b

(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) a a' = Encimar a a'

(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) a a' = Juntar 1 1 a a'

cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto a b c d = (.-.) ((///) a b) ((///) c d)

pureDib :: a -> Dibujo a
pureDib a = Basica a

encimar4 :: Dibujo a -> Dibujo a
encimar4 a =  (^^^) ((^^^) a (Rotar(a))) ((^^^) (r180 a) (r270 a))

ciclar :: Dibujo a -> Dibujo a
ciclar a = cuarteto (Rotar(a)) (a) (r180(a)) (r270(a))

cambia :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
cambia f (Basica a) =  f a
cambia f (Rotar a) = Rotar (cambia f a)
cambia f (Espejar a) = Espejar (cambia f a) 
cambia f (Rot45 a) = Rot45 (cambia f a)
cambia f (Apilar n m a a') = Apilar n m (cambia f a) (cambia f a')
cambia f (Juntar n m a a') = Juntar n m (cambia f a) (cambia f a')
cambia f (Encimar a a') = Encimar (cambia f a) (cambia f a')

mapDib :: (a -> b) -> Dibujo a -> Dibujo b
mapDib f (Basica a) = Basica (f a)
mapDib f (Rotar a) = Rotar (mapDib f a)
mapDib f (Espejar a) = Espejar (mapDib f a)
mapDib f (Rot45 a) = Rot45 (mapDib f a)
mapDib f (Apilar n m a a') = Apilar n m (mapDib f a) (mapDib f a')
mapDib f (Juntar n m a a') = Juntar n m (mapDib f a) (mapDib f a')
mapDib f (Encimar a a') = Encimar (mapDib f a) (mapDib f a')

sem :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) ->
          (Int -> Int -> b -> b -> b) -> 
          (Int -> Int -> b -> b -> b) -> 
          (b -> b -> b) ->
          Dibujo a -> b

sem q w e r t y l (Basica a) = q a
sem q w e r t y l (Rotar a) = w (sem q w e r t y l a)
sem q w e r t y l (Espejar a) = e (sem q w e r t y l a)
sem q w e r t y l (Rot45 a) = r (sem q w e r t y l a)
sem q w e r t y l (Apilar n m a a') = t n m (sem q w e r t y l a) (sem q w e r t y l a')
sem q w e r t y l (Juntar n m a a') = y n m (sem q w e r t y l a) (sem q w e r t y l a')
sem q w e r t y l (Encimar a a') = l (sem q w e r t y l a) (sem q w e r t y l a')

limpia :: Pred a -> a -> Dibujo a -> Dibujo a
limpia p n d = cambia aux d
  where aux x = if p x then Basica n else Basica x

-- or para anyDib
or' :: Int -> Int -> Bool -> Bool -> Bool
or' _ _ b1 b2 = b1 || b2

anyDib :: Pred a -> Dibujo a -> Bool
anyDib p d = sem p id id id or' or' (||) d

and' :: Int -> Int -> Bool -> Bool -> Bool
and' _ _ b1 b2 = b1 && b2

allDib :: Pred a -> Dibujo a -> Bool
allDib p d = sem p id id id and' and' (&&) d

-- devuelve a una lista de una basica
everyBasica :: a -> [a]
everyBasica a = [a] 

-- toma dos basicas juntadas o apiladas y devuelve una lista de ellas
everyJuntarApilar :: Int -> Int -> [a] -> [a]-> [a]
everyJuntarApilar _ _ a1 a2 = a1 ++ a2

-- toma dos basicas encimadas y devuelve la lista de ellas 
everyEncimar :: [a] -> [a] -> [a]
everyEncimar a1 a2 = a1 ++ a2

every :: Dibujo a -> [a]
every d = sem everyBasica id id id everyJuntarApilar everyJuntarApilar 
               everyEncimar d

sumar :: Eq a => a -> [(a, Int)] -> Int
sumar a [] = 0
sumar a ((elem1, nro1):ns1) = if elem1 == a then (1 + sumar a ns1) else (0 + sumar a ns1)

contarElementos :: Eq a => [(a, Int)] -> [(a, Int)] -> [(a, Int)]
contarElementos a [] = []
contarElementos a ((elem, nro):xs) = [(elem, sumar elem a)] ++ contarElementos a xs

contarBasica :: Eq a=> a -> [(a, Int)]
contarBasica a = [(a, 1)]

contarJuntarApilar :: Eq a => Int -> Int-> [(a, Int)]-> [(a, Int)] -> [(a, Int)]
contarJuntarApilar _ _ a a' = contarElementos (a ++ a') (a ++ a')

contarEncimar :: Eq a => [(a, Int)] -> [(a, Int)] -> [(a, Int)]
contarEncimar a a' = contarElementos (a ++ a') (a ++ a')

contar :: Eq a => Dibujo a -> [(a, Int)]
contar d = sem contarBasica id id id contarJuntarApilar contarJuntarApilar contarEncimar d

-- funcion para desc          
stringJuntarApilar :: Int -> Int -> String -> String -> String
stringJuntarApilar n m a1 a2 = show n ++ show m ++ a1 ++ a2

desc :: (a -> String) -> Dibujo a -> String
desc f d = sem f id id id stringJuntarApilar stringJuntarApilar (++) d

esRot360 :: Pred(Dibujo a)
esRot360 (Basica a) = True
esRot360 (Rotar(Rotar(Rotar(Rotar a)))) = False
esRot360 (Rotar a) = True && esRot360 a  
esRot360 (Espejar a) = True && esRot360 a 
esRot360 (Rot45 a) = True && esRot360 a
esRot360 (Apilar n m a a') = True && esRot360 a && esRot360 a'
esRot360 (Juntar n m a a') = True && esRot360 a && esRot360 a'
esRot360 (Encimar a a') = True && esRot360 a && esRot360 a'

esFlip2 :: Pred(Dibujo a)
esFlip2 (Basica a) = True
esFlip2 (Rotar a) = True && esFlip2 a  
esFlip2 (Espejar(Espejar a)) = False
esFlip2 (Espejar a) = True && esFlip2 a 
esFlip2 (Rot45 a) = True && esFlip2 a
esFlip2 (Apilar n m a a') = True && esFlip2 a && esFlip2 a'
esFlip2 (Juntar n m a a') = True && esFlip2 a && esFlip2 a'
esFlip2 (Encimar a a') = True && esFlip2 a && esFlip2 a'

check :: Pred (Dibujo a) -> String -> Dibujo a -> Either String (Dibujo a)
check p s d = if p d then Right d else Left s

todoBien :: Dibujo a -> Either [String] (Dibujo a)
todoBien d = case resRot of Right d -> case resFlip of Right d -> Right d
                                                       Left error2 -> Left [error2]
                            Left error1 -> case resFlip of Right d -> Left [error1]
                                                           Left error2 -> Left [error1,error2] 
            where (resRot,resFlip) = (check esRot360 "ErrorRot" d,check esFlip2 "ErrorFlip" d)

noRot360 :: Dibujo a -> Dibujo a
noRot360 (Basica a) = Basica a
noRot360 (Rotar(Rotar(Rotar(Rotar a)))) = noRot360 a
noRot360 (Rotar a) = Rotar(noRot360 a)
noRot360 (Espejar a) = Espejar(noRot360 a) 
noRot360 (Rot45 a) =Rot45( noRot360 a)
noRot360 (Apilar n m a a') = Apilar n m (noRot360 a) (noRot360 a')
noRot360 (Juntar n m a a') = Juntar n m (noRot360 a) (noRot360 a')
noRot360 (Encimar a a') = Encimar (noRot360 a) (noRot360 a')

noFlip2  :: Dibujo a -> Dibujo a
noFlip2 (Basica a) = Basica a
noFlip2 (Rotar a) = Rotar(noFlip2 a)
noFlip2 (Espejar (Espejar a)) = noFlip2 a
noFlip2 (Espejar a) = Espejar(noFlip2 a)
noFlip2 (Rot45 a) = Rot45(noFlip2 a)
noFlip2 (Apilar n m a a') = Apilar n m (noFlip2 a) (noFlip2 a')
noFlip2 (Juntar n m a a') = Juntar n m (noFlip2 a) (noFlip2 a')
noFlip2 (Encimar a a') = Encimar (noFlip2 a) (noFlip2 a')
