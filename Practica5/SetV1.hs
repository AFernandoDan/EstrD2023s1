module SetV1
  (Set, emptyS, addS, belongsS, sizeS, removeS, unionS, setToList)
  where

data Set a = S    [a]         Int
              --  Elementos   Cantidad de elementos
  {-  INV.REP.:
        * En (S es c), se cumple que:
          * es no tiene elementos repetidos
          * c es la cantidad de elementos de la lista es
        }

      Validos:
        S [] 0
        S ['a'] 1
        S [1,2,3] 3

      Invalidos:
        S [] 1
        S ['h', 'o', 'l', 'a'] 0
        S [1,2,1] 3
  -}

emptyS :: Set a
-- Crea un conjunto vacío.
emptyS = S [] 0
-- Costo: O(1)

addS :: Eq a => a -> Set a -> Set a
-- Dados un elemento y un conjunto, agrega el elemento al conjunto.
addS x (S es c) =
  if elem x es
    then S es c
    else S (x:es) (c+1)
-- Costo: O(n)

belongsS :: Eq a => a -> Set a -> Bool
-- Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
belongsS x (S xs _) = elem x xs
-- Costo: O(n)

sizeS :: Eq a => Set a -> Int
-- Devuelve la cantidad de elementos distintos de un conjunto.
sizeS (S _ c) = c
-- Costo: O(1)

-- DUDAS EN ESTE EJERCICIO
removeS :: Eq a => a -> Set a -> Set a
-- Borra un elemento del conjunto.
removeS x (S xs c) = S (sacar x xs) (length (sacar x xs))
-- Costo: O(n)

sacar :: Eq a => a -> [a] -> [a]
sacar n [] = []
sacar n (x:xs) =
  if n == x
    then xs
    else x : sacar n xs
-- Costo: O(n)

unionS :: Eq a => Set a -> Set a -> Set a
-- Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos. conjuntos.
unionS (S xs c) s2 = addMany xs s2
-- Costo: O(n^2)

addMany :: Eq a => [a] -> Set a -> Set a
addMany [] s = s
addMany (x :xs) s = addS x (addMany xs s)
-- Costo: O(n^2)

setToList :: Eq a => Set a -> [a]
-- Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
setToList (S xs c) = xs
-- Costo: O(1)

-- 1. Implementar la variante del tipo abstracto Set con una lista que no tiene repetidos y guarda
-- la cantidad de elementos en la estructura.
-- Nota: la restricción Eq aparece en toda la interfaz se utilice o no en todas las operaciones
-- de esta implementación, pero para mantener una interfaz común entre distintas posibles
-- implementaciones estamos obligados a escribir así los tipos.

-- Costos totales V1
-- emptyS: O(1)
-- addS: O(n)
-- belongsS: O(n)
-- sizeS: O(1)
-- removeS: O(n)
-- unionS: O(n^2)
-- setToList: O(1)