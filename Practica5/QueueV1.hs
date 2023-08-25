module QueueV1
  (Queue, emptyQ, isEmptyQ, enqueue, firstQ, dequeue)
  where

-- 1. Implemente el tipo abstracto Queue utilizando listas. Los elementos
--  deben encolarse por el final de la lista y desencolarse por delante.

data Queue a = Q  [a]
            --    Elementos
  {-
      Observación:
        * Los elementos se encolan por el final de la lista y se desencolan
          por el principio de la lista.
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
enqueue e (Q ys) = Q (consAlFinal e ys)
-- Costo: O(n)

consAlFinal :: a -> [a] -> [a]
consAlFinal e [] = e:[]
consAlFinal e (x: xs) = x:consAlFinal e xs
-- Costo: O(n)

firstQ :: Queue a -> a
-- Dada una cola devuelve el primer elemento de la cola.
-- Precondición: La cola no es vacia
firstQ (Q xs) = head xs
-- Costo: O(1)

dequeue :: Queue a -> Queue a
-- Dada una cola la devuelve sin su primer elemento.
-- Precondición: La cola no es vacia
dequeue (Q xs) = Q (tail xs)
-- Costo: O(1)
