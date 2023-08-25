module QueueV3
  (Queue, emptyQ, isEmptyQ, enqueue, firstQ, dequeue)
  where

-- 2. Implemente ahora la versión que agrega por delante y quita por el final
--  de la lista. Compare la eficiencia entre ambas implementaciones.

data Queue a = Q  [a]         [a]
            --    FrontStack  BackStack
 {-
    INV.REP.:
      *  En Q fs bs, se cumple que si fs se encuentra vacía, entonces la cola se encuentra vacía.
    Observación:
      * Los elementos se encolan por el principio de la lista y se desencolan
        por el final de la lista.

    VALIDA:
      Q [1] []
      Q [1,2] [3]
      Q [] []

    INVALIDA
      Q [] [2]
 -}

emptyQ :: Queue a
-- Crea una cola vacía.
emptyQ = Q [] []
-- Costo: O(1)

isEmptyQ :: Queue a -> Bool
-- Dada una cola indica si la cola está vacía.
isEmptyQ (Q fs bs) = null fs
-- Costo: O(1)

enqueue :: a -> Queue a -> Queue a
-- Dados un elemento y una cola, agrega ese elemento a la cola.
enqueue x (Q fs bs) =
  if null fs
    then Q [x] []
    else Q fs (x:bs)
-- Costo: O(1)

firstQ :: Queue a -> a
-- Dada una cola devuelve el primer elemento de la cola.
-- Precondición: La cola no es vacia
firstQ (Q fs bs) = head fs
-- Costo: O(1)

dequeue :: Queue a -> Queue a
-- Dada una cola la devuelve sin su primer elemento.
-- Precondición: La cola no es vacia
dequeue (Q fs bs) =
  if null (tail fs)
    then Q (reversa bs) []
    else Q (tail fs) bs
-- Costo: O(n^2)
-- este costo es cada vez que fs tenga un solo elemento. En los
-- otros casos es O(1)

reversa :: [a] -> [a]
reversa [] = []
reversa (x:xs) = agregarAlFinal (reversa xs) x
-- Costo: O(n^2)

agregarAlFinal :: [a] -> a -> [a]
agregarAlFinal [] e = [e]
agregarAlFinal (x:xs) e = x: agregarAlFinal xs e
-- Costo: O(n)