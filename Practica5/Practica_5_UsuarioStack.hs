import StackV1

-- 4. Stack (pila)

-- duda con el proposito, no entiendo cual es el orden de apilación
apilar :: [a] -> Stack a
-- Dada una lista devuelve una pila sin alterar el orden de los elementos
apilar [] = emptyS
apilar (x:xs) = push x (apilar xs)

desapilar :: Stack a -> [a]
-- Dada una pila devuelve una lista sin alterar el orden de los elementos.
desapilar s =
  if isEmptyS s
    then []
    else top s:desapilar (pop s)

-- duda aca: no entiendo desde donde se calcula la posición
insertarEnPos :: Int -> a -> Stack a -> Stack a
-- Dada una posicion válida en la stack y un elemento, ubica dicho elemento en dicha
-- posición (se desapilan elementos hasta dicha posición y se inserta en ese lugar).
-- Precond: La posición debe ser valida en el stack
insertarEnPos 0 e s = push e s
insertarEnPos p e s = push (top s) (insertarEnPos (p-1) e (pop s))