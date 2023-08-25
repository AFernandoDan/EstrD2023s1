module StackV1
  (Stack, emptyS, isEmptyS, push, pop, top, lenS)
  where

data Stack a = S [a]        Int
--               Elementos  Cantidad de elementos
{-
    Inv.Rep.:
      * En (S xs c), se cumple que c == length xs

    Validos:
      S [] 0
      S [10] 1
      S [1,2,3] 3

    Invalidos:
      S [] 1
      S [1] = 0
      S [1,2,3] = 2

    Observación:
      * Los últimos elementos agregados al stack son los primeros en salir.
-}

emptyS :: Stack a
-- Crea una pila vacía.
emptyS = S [] 0
-- Costo: O(1)

isEmptyS :: Stack a -> Bool
-- Dada una pila indica si está vacía.
isEmptyS (S _ c) = c == 0
-- Costo: O(1)

push :: a -> Stack a -> Stack a
-- Dados un elemento y una pila, agrega el elemento a la pila.
push x (S xs c) = S (x:xs) (c+1)
-- Costo: O(1)

top :: Stack a -> a
-- Dada un pila devuelve el elemento del tope de la pila.
-- Precond: la pila no es vacia
top (S xs _) = head xs
-- Costo: O(1)

pop :: Stack a -> Stack a
-- Dada una pila devuelve la pila sin el primer elemento.
-- Precond: la pila no es vacia
pop (S xs c) = S (tail xs) (c-1)
-- Costo: O(1)

lenS :: Stack a -> Int
-- Dada la cantidad de elementos en la pila.
-- Costo: constante.
lenS (S _ c) = c
-- Costo: O(1)