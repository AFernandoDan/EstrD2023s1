-- Funciones utiles
unoSi :: Bool -> Int
unoSi True  = 1
unoSi False = 0

singularSi :: a -> Bool -> [a]
singularSi x True  = x:[]
singularSi _ False = []

-- 1. Tipos recursivos simples
data Color = Azul | Rojo deriving Show
data Celda = Bolita Color Celda | CeldaVacia deriving Show

-- Instancias de prueba
celda1 :: Celda
celda1 = Bolita Rojo (Bolita Azul (Bolita Rojo CeldaVacia))

{- nroBolitas :: Color -> Celda -> Int
Dados un color y una celda, indica la cantidad de bolitas de ese color. Nota: pensar si ya
existe una operación sobre listas que ayude a resolver el problema. -}

nroBolitas :: Color -> Celda -> Int
nroBolitas c1 CeldaVacia = 0
nroBolitas c1 (Bolita c2 cel) = unoSi (sonMismoColor c1 c2) + nroBolitas c1 cel

sonMismoColor :: Color -> Color -> Bool
sonMismoColor Rojo Rojo = True
sonMismoColor Azul Azul = True
sonMismoColor _ _ = False

{- poner :: Color -> Celda -> Celda
Dado un color y una celda, agrega una bolita de dicho color a la celda -}

poner :: Color -> Celda -> Celda
poner c cel = Bolita c cel

sacar :: Color -> Celda -> Celda
sacar c CeldaVacia = CeldaVacia
sacar c1 (Bolita c2 cel) =
  if sonMismoColor c1 c2
    then cel
    else Bolita c2 (sacar c1 cel)

{- ponerN :: Int -> Color -> Celda -> Celda
Dado un número n, un color c, y una celda, agrega n bolitas de color c a la celda -}
ponerN :: Int -> Color -> Celda -> Celda
ponerN 0 c cel = cel
ponerN n c cel = ponerN (n-1) c (poner c cel)

-- 1.2. Camino hacia el tesoro
data Objeto = Cacharro | Tesoro deriving Show
data Camino = Fin | Cofre [Objeto] Camino | Nada Camino deriving Show

-- Instancias de prueba
camino1 :: Camino
camino1 = Cofre [Cacharro, Cacharro] (Cofre [Tesoro] (Cofre [Cacharro, Tesoro, Tesoro] Fin))

camino2 :: Camino
camino2 = Nada (Nada (Nada (Nada Fin)))

hayTesoro :: Camino -> Bool
hayTesoro Fin = False
hayTesoro (Cofre os c) = tieneTesoro os || hayTesoro c
hayTesoro (Nada c) = hayTesoro c

tieneTesoro :: [Objeto] -> Bool
tieneTesoro [] = False
tieneTesoro (x: xs) = esTesoro x || tieneTesoro xs

esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro _ = False

{- pasosHastaTesoro :: Camino -> Int
Indica la cantidad de pasos que hay que recorrer hasta llegar al primer cofre con un tesoro.
Si un cofre con un tesoro está al principio del camino, la cantidad de pasos a recorrer es 0.
Precondición: tiene que haber al menos un tesoro. -}
pasosHastaTesoro :: Camino -> Int
  -- Precondición: tiene que haber al menos un tesoro.
pasosHastaTesoro (Cofre os c) =
  if (tieneTesoro os)
    then 0
    else 1 + pasosHastaTesoro c
pasosHastaTesoro (Nada c) = 1 + pasosHastaTesoro c

{- hayTesoroEn :: Int -> Camino -> Bool
Indica si hay un tesoro en una cierta cantidad exacta de pasos. Por ejemplo, si el número de
pasos es 5, indica si hay un tesoro en 5 pasos. -}
hayTesoroEn :: Int -> Camino -> Bool
  -- Precondición: Se deben poder avanzar n pasos en el camino.
hayTesoroEn 0 c = hayTesoroC c
hayTesoroEn n c = hayTesoroEn (n-1) (avanzarPasoEn c)

avanzarPasoEn :: Camino -> Camino
 -- Precondición el camino no puede ser fin.
avanzarPasoEn (Nada c) = c
avanzarPasoEn (Cofre os c) = c

hayTesoroC :: Camino -> Bool
hayTesoroC (Cofre os _) = tieneTesoro os
hayTesoroC _ = False

{- alMenosNTesoros :: Int -> Camino -> Bool
Indica si hay al menos “n” tesoros en el camino. -}
alMenosNTesoros :: Int -> Camino -> Bool
alMenosNTesoros 0 _ = True
alMenosNTesoros n Fin = False
alMenosNTesoros n (Nada c) = alMenosNTesoros n c
alMenosNTesoros n (Cofre os c) =
  tieneAlMenosNTesorosO n os || alMenosNTesoros (n - cantidadTesorosO os) c

-- Otra opción seria: alMenosNTesoros n c = cantTesorosC c >= n
-- Desventajas: Requiere recorrer todo el camino
-- Ventaja: Es mas sencilla la subtarea cantTesorosC c

cantidadTesorosO :: [Objeto] -> Int
cantidadTesorosO [] = 0
cantidadTesorosO (x:xs) = unoSi(esTesoro x) + cantidadTesorosO xs


tieneAlMenosNTesorosO :: Int -> [Objeto] -> Bool
tieneAlMenosNTesorosO n os = n >= cantidadTesorosO os

cantTesorosEntre :: Int -> Int -> Camino -> Int
cantTesorosEntre n m c = cantTesorosHasta m (avanzarNPasosEn n c)

cantTesorosHasta :: Int -> Camino -> Int
cantTesorosHasta 0 c = cantidadDeTesorosCActual c
cantTesorosHasta n c =
  cantidadDeTesorosCActual c + cantTesorosHasta (n-1) (avanzarPasoEn c) 

avanzarNPasosEn :: Int -> Camino -> Camino
avanzarNPasosEn 0 c = c
avanzarNPasosEn n c = avanzarNPasosEn (n-1) (avanzarPasoEn c)

cantidadDeTesorosCActual :: Camino -> Int
cantidadDeTesorosCActual Fin = 0
cantidadDeTesorosCActual (Nada _) = 0
cantidadDeTesorosCActual (Cofre os _) = cantidadTesorosO os

-- 2. Tipos arbóreos
data Tree a = EmptyT | NodeT a (Tree a) (Tree a) deriving Show

-- Instancias de prueba
tree0 :: Tree Int
tree0 = NodeT 1 (NodeT 2 EmptyT EmptyT) EmptyT

tree1 :: Tree Int
tree1 = NodeT 1 (NodeT 2 EmptyT EmptyT) (NodeT 3 EmptyT EmptyT)

tree2 :: Tree Int
tree2 = NodeT 1 (NodeT 2 (NodeT 4 EmptyT EmptyT) EmptyT) (NodeT 3 EmptyT EmptyT)

sumarT :: Tree Int -> Int
sumarT EmptyT = 0
sumarT (NodeT n t1 t2) = n + sumarT t1 + sumarT t2

sizeT :: Tree a -> Int
sizeT EmptyT = 0
sizeT (NodeT _ t1 t2) = 1 + sizeT t1 + sizeT t2

mapDobleT :: Tree Int -> Tree Int
mapDobleT EmptyT = EmptyT
mapDobleT (NodeT n t1 t2) =
  NodeT (2*n) (mapDobleT t1) (mapDobleT t2)

perteneceT :: Eq a => a -> Tree a -> Bool
perteneceT x EmptyT = False
perteneceT x (NodeT e t1 t2) =
  x == e || perteneceT e t1 || perteneceT e t2

aparicionesT :: Eq a => a -> Tree a -> Int
aparicionesT x EmptyT = 0
aparicionesT x (NodeT e t1 t2) =
  unoSi(x == e) + aparicionesT x t1 + aparicionesT x t2

leaves :: Tree a -> [a]
leaves EmptyT = []
leaves (NodeT x t1 t2) =
  singularSi x (esVacioT t1 && esVacioT t2) ++ leaves t1 ++ leaves t2

esVacioT :: Tree a -> Bool
esVacioT EmptyT = True
esVacioT _ = False

heightT :: Tree a -> Int
heightT EmptyT = 0
heightT (NodeT _ t1 t2) = 1 + max (heightT t1) (heightT t2)

mirrorT :: Tree a -> Tree a
mirrorT EmptyT = EmptyT
mirrorT (NodeT x t1 t2) = NodeT x (mirrorT t2) (mirrorT t1)

toList :: Tree a -> [a]
toList EmptyT = []
toList (NodeT x t1 t2) = toList t1 ++ [x] ++ toList t2

levelN :: Int -> Tree a -> [a]
levelN _ EmptyT = []
levelN 0 (NodeT x _ _) = x:[]
levelN n (NodeT _ t1 t2) = levelN (n-1) t1 ++ levelN (n-1) t2

listPerLevel :: Tree a -> [[a]]
listPerLevel EmptyT = [] 
listPerLevel (NodeT x t1 t2) =
  [x] : unirTodos (listPerLevel t1) (listPerLevel t2)

unirTodos :: [[a]] -> [[a]] -> [[a]]
unirTodos [] ys = ys
unirTodos xs [] = xs
unirTodos (x:xs) (y:ys) = (x ++ y): unirTodos xs ys 

ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT = []
ramaMasLarga (NodeT x t1 t2) =
   x : elegirLaMasLarga (ramaMasLarga t1) (ramaMasLarga t2)

elegirLaMasLarga :: [a] -> [a] -> [a]
elegirLaMasLarga os1 os2 = if length os1 > length os2
                            then os1
                            else os2

todosLosCaminos :: Tree a -> [[a]] -- dudas con esta solución
todosLosCaminos EmptyT = []
todosLosCaminos (NodeT x t1 t2) =
  if null (todosLosCaminos t1) && null (todosLosCaminos t2)
    then [[x]]
    else consATodos x ((todosLosCaminos t1) ++ (todosLosCaminos t2))

consATodos :: a -> [[a]] -> [[a]]
consATodos x [] = []
consATodos x (y:ys) = (x:y):(consATodos x ys)

-- 2.2. Expresiones Aritméticas
data ExpA = Valor Int
  | Sum ExpA ExpA
  | Prod ExpA ExpA
  | Neg ExpA deriving Show

eval :: ExpA -> Int
eval (Valor n) = n
eval (Sum e1 e2) = (eval e1) + (eval e2) 
eval (Prod e1 e2) = (eval e1) * (eval e2)
eval (Neg e) = -(eval e)

simplificar :: ExpA -> ExpA
simplificar (Valor n) = Valor n
simplificar (Sum e1 e2) = simplificarSum (simplificar e1) (simplificar e2)
simplificar (Prod e1 e2) = simplificarProd (simplificar e1) (simplificar e2)
simplificar (Neg e) = simplificarNeg (simplificar e)

simplificarSum :: ExpA -> ExpA -> ExpA
simplificarSum (Valor 0) e2 = e2
simplificarSum e1 (Valor 0) = e1
simplificarSum e1 e2 = Sum e1 e2 

simplificarProd :: ExpA -> ExpA -> ExpA
simplificarProd (Valor 0) e2 = Valor 0
simplificarProd e1 (Valor 0) = Valor 0
simplificarProd (Valor 1) e2 = e2
simplificarProd e1 (Valor 1) = e1
simplificarProd e1 e2 = Prod e1 e2 

simplificarNeg :: ExpA -> ExpA
simplificarNeg (Neg e) = e
simplificarNeg e = Neg e

-- ejercicios en duda o a discutir

-- hayAlMenosNTesoros :: Camino -> Bool

-- todosLosCaminos (NodeT 1 EmptyT EmptyT) = [[1]]
-- todosLosCaminos (NodeT 1 (NodeT 2 EmptyT EmptyT) EmptyT) = [[1,2], [1]]

-- falta hacer
-- cantTesorosEntre :: Int -> Int -> Camino -> Int
-- cantTesorosEntre n m c = cantTesorosHasta n c - cantTesorosHasta m c