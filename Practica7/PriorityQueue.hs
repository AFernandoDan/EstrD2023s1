module PriorityQueue (PriorityQueue, emptyPQ, isEmptyPQ, insertPQ, findMinPQ, deleteMinPQ) where

data PriorityQueue a = PQ [a]
{-  INV.REP: En PQ xs se cumple que si xs no esta vacia head xs es el minimo
    VALIDOS:
      PQ []
      PQ [1,2,3]

    INVALIDOS:
      PQ [2, 1]
-}

-- O(1)
emptyPQ :: PriorityQueue a
-- Propósito: devuelve una priority queue vacía.
emptyPQ = PQ []

-- O(1)
isEmptyPQ :: PriorityQueue a -> Bool
-- Propósito: indica si la priority queue está vacía.
isEmptyPQ (PQ xs) = null xs

-- O(n)
insertPQ :: Ord a => a -> PriorityQueue a -> PriorityQueue a
-- Propósito: inserta un elemento en la priority queue.
insertPQ x (PQ xs) = PQ (agregar x xs)

-- O(n)
agregar :: Ord a => a -> [a] -> [a]
agregar x [] = [x]
agregar x (x':xs) = if x <= x' then x:x':xs else x': agregar x xs  

-- O(1)
findMinPQ :: Ord a => PriorityQueue a -> a
-- Propósito: devuelve el elemento más prioriotario (el mínimo) de la priority queue.
-- Precondición: parcial en caso de priority queue vacía.
findMinPQ (PQ xs) = head xs

-- O(1)
deleteMinPQ :: Ord a => PriorityQueue a -> PriorityQueue a
-- Propósito: devuelve una priority queue sin el elemento más prioritario (el mínimo).
-- Precondición: parcial en caso de priority queue vacía
deleteMinPQ (PQ xs) = PQ (tail xs)