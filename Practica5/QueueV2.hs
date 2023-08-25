module QueueV2
  (Queue, emptyQ, isEmptyQ, enqueue, firstQ, dequeue)
  where

-- 2. Implemente ahora la versión que agrega por delante y quita por el final
--  de la lista. Compare la eficiencia entre ambas implementaciones.

data Queue a = Q  [a]
            --    Elementos
 {-
    Observación:
      * Los elementos se encolan por el principio de la lista y se desencolan
        por el final de la lista.
 -}

emptyQ :: Queue a
-- Crea una cola vacía.
emptyQ = Q []
-- Costo: O(1)

isEmptyQ :: Queue a -> Bool
-- Dada una cola indica si la cola está vacía.
isEmptyQ (Q xs) = null xs
-- Costo: O(1)

enqueue :: a -> Queue a -> Queue a
-- Dados un elemento y una cola, agrega ese elemento a la cola.
enqueue e (Q ys) = Q (e:ys)
-- Costo: O(1)

firstQ :: Queue a -> a
-- Dada una cola devuelve el primer elemento de la cola.
-- Precondición: La cola no es vacia
firstQ (Q xs) = last xs
-- Costo: O(n)

dequeue :: Queue a -> Queue a
-- Dada una cola la devuelve sin su primer elemento.
-- Precondición: La cola no es vacia
dequeue (Q xs) = Q (sinElUltimo xs)
-- Costo: O(n)

sinElUltimo :: [a] -> [a]
  -- Precondición: la lista dada no es vacia
sinElUltimo (x: xs) =
  if null xs
    then []
    else x: sinElUltimo xs
-- Costo: O(n)