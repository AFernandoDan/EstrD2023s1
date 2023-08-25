module SetV2
  (Set, emptyS, addS, belongsS, sizeS, removeS, unionS, setToList)
  where

data Set a = S  [a]
            --  Elementos

emptyS :: Set a
-- Crea un conjunto vacío.
emptyS = S []
-- Costo: O(1)

addS :: Eq a => a -> Set a -> Set a
-- Dados un elemento y un conjunto, agrega el elemento al conjunto.
addS x (S xs) = S (x:xs)
-- Costo: O(1)

belongsS :: Eq a => a -> Set a -> Bool
-- Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
belongsS x (S xs) = elem x xs
-- Costo: O(n)

sizeS :: Eq a => Set a -> Int
-- Devuelve la cantidad de elementos distintos de un conjunto.
sizeS (S xs) = cantElementosDistintos xs
-- Costo: O(n^2)

cantElementosDistintos :: Eq a => [a] -> Int
cantElementosDistintos [] = 0
cantElementosDistintos (x:xs) = unoSi (not (elem x xs)) + cantElementosDistintos xs
-- Costo: O(n^2)

unoSi :: Bool -> Int
unoSi True  = 1
unoSi False = 0
-- Costo: O(1)

removeS :: Eq a => a -> Set a -> Set a
-- Borra un elemento del conjunto.
removeS x (S xs) = S (sacarTodos x xs)
-- Costo: O(n)

sacarTodos :: Eq a => a -> [a] -> [a]
sacarTodos x [] = []
sacarTodos x (y:ys) =
  if x==y
    then sacarTodos x ys
    else x:sacarTodos x ys
-- Costo: O(n)

unionS :: Eq a => Set a -> Set a -> Set a
-- Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos. conjuntos.
unionS (S xs) (S ys) = S (xs++ys)
-- Costo: O(n)

setToList :: Eq a => Set a -> [a]
-- Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
setToList (S xs) = sinRepetidos xs
-- Costo: O(n^2)

sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (x:xs) =
  if elem x xs
    then sinRepetidos xs
    else x : sinRepetidos xs
-- Costo: O(n^2)

-- Costos     V1        V2
-- emptyS:    O(1)      O(1)
-- addS:      O(n)      O(1)
-- belongsS:  O(n)      O(n)
-- sizeS:     O(1)      O(n^2)
-- removeS:   O(n)      O(n)
-- unionS:    O(n^2)    O(n)
-- setToList: O(1)      O(n^2)