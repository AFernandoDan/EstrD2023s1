import PriorityQueue
import Data.Maybe (fromJust)

-- Costos de heapSort suponiendo que el usuario utiliza una priority queue
-- con costos logarítmicos de inserción y borrado (o sea, usa una Heap como
-- tipo de representación).

-- insertPQ costo O(log n)
-- deleteMinPQ costo O(log n)
-- findMinPQ costo O(1) 

-- O((pqToList) + (listToPQ))
-- O((n * log n)+(n * log n)) = O(2*n*log n) = O(n*log n)
heapSort :: Ord a => [a] -> [a]
heapSort xs = pqToList (listToPQ xs)

-- Suponiendo que la funcion findMinPQ tiene un costo de O(1)
-- O((cantidad elementos lista) * (costo de borrado))
-- O(n * log n)
listToPQ :: Ord a => [a] -> PriorityQueue a
listToPQ [] = emptyPQ
listToPQ (x:xs) = insertPQ x (listToPQ xs)

-- Suponiendo que la funcion findMinPQ tiene un costo de O(1)
-- O((cantidad elementos pq) * (costo de borrado))
-- O(n * log n)
pqToList :: Ord a => PriorityQueue a -> [a]
pqToList pq =
  if isEmptyPQ pq
    then []
    else findMinPQ pq: pqToList (deleteMinPQ pq)

-- Ejercicio 2
-- Implementar las siguientes funciones suponiendo que reciben un árbol binario que cumple los
-- invariantes de BST y sin elementos repetidos (despreocuparse por el hecho de que el árbol puede
-- desbalancearse al insertar o borrar elementos). En todos los costos, N es la cantidad de elementos
-- del árbol. Justificar por qué la implementación satisface los costos dados.

data Tree a = EmptyT | NodeT a (Tree a) (Tree a) deriving Show

belongsBST :: Ord a => a -> Tree a -> Bool
-- Propósito: dado un BST dice si el elemento pertenece o no al árbol.
-- Costo: O(log N)
belongsBST e EmptyT = False
belongsBST e (NodeT x ti td) =
  if e==x
    then True
    else if e<x
      then belongsBST e ti
      else belongsBST e td 

insertBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST inserta un elemento en el árbol.
-- Costo: O(log N)
insertBST e EmptyT = NodeT e EmptyT EmptyT
insertBST e (NodeT x ti td) =
  if e==x
    then NodeT e ti td
    else if e<x
      then NodeT x (insertBST e ti) td
      else NodeT x ti (insertBST e td)

deleteBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST borra un elemento en el árbol.
-- Costo: O(log N)
deleteBST e EmptyT = EmptyT
deleteBST e (NodeT x ti td) =
  if e==x
    then rearmarBST ti td
    else if e<x
      then NodeT x (deleteBST e ti) td
      else NodeT x ti (deleteBST e td)

rearmarBST :: Ord a => Tree a -> Tree a -> Tree a
rearmarBST ti EmptyT = ti
rearmarBST ti td =
  let (m, td') = splitMinBST td in
    NodeT m ti td'

splitMinBST :: Ord a => Tree a -> (a, Tree a)
-- Propósito: dado un BST devuelve un par con el mínimo elemento y el árbol sin el mismo.
-- Costo: O(log N) 
splitMinBST (NodeT x EmptyT td) = (x, td)
splitMinBST (NodeT x ti td) =
  let (m, ti') = splitMaxBST ti in
    (m, NodeT x ti' td)

splitMaxBST :: Ord a => Tree a -> (a, Tree a)
-- Propósito: dado un BST devuelve un par con el máximo elemento y el árbol sin el mismo.
-- Costo: O(log N)
splitMaxBST (NodeT x ti EmptyT) = (x, ti)
splitMaxBST (NodeT x ti td) =
  let (m, td') = splitMaxBST td in
    (m, NodeT x ti td')

ejTBST :: Tree Int
ejTBST = NodeT 10 (NodeT 7 (NodeT 4 (NodeT 1 EmptyT EmptyT) EmptyT) (NodeT 9 EmptyT EmptyT)) (NodeT 12 (NodeT 11 EmptyT EmptyT) (NodeT 20 EmptyT EmptyT))

-- ejBST no balanceado
ejBSTNoBalanceado :: Tree Int
ejBSTNoBalanceado = NodeT 5 EmptyT (NodeT 7 (NodeT 6 EmptyT EmptyT)  EmptyT)

-- La implementación satisface los costos dados ya que
-- en promedio se necesitaran tantas operaciones como altura tenga el arbol para encontrar
-- un elemento o insertarlo. Para borrar un elemento se necesita encontrarlo lo cual es
-- log n, y rearmar el arbol sin dicho elemento lo que tambien es otra operación que depende
-- de la altura del arbol.
-- resultando en un costo O(log n + log n) = O(2log n) = O(log n). Esto es asi porque,
-- el factor 2 en este caso es depreciable en la eficiencia. Esto al menos
-- para las 5 primeras operaciones

-- Propósito: indica si el árbol cumple con los invariantes de BST.
-- Costo: O(N^2)
esBST :: Ord a => Tree a -> Bool
esBST EmptyT = True
esBST (NodeT x ti td) = sonMenoresQue x ti && sonMayoresQue x td && esBST ti && esBST td

-- sonMenoresQue x ti && sonMayoresQue -> Costo: O(N+N) = O(2N) = O(N)
-- esBST ti && esBST td -> Costo: O(N+N) = O(2N) = O(N) 
-- costo total: O(N*N) = O(N^2)

-- Costo: O(1+N+N) = O(N)
sonMenoresQue :: Ord a => a -> Tree a -> Bool
sonMenoresQue x EmptyT = True
sonMenoresQue x (NodeT y ti td) =
  y<x &&                -- O(1)
  sonMenoresQue x ti && -- O(N)
  sonMenoresQue x td    -- O(N)

-- Costo: O(1+N+N) = O(N)
sonMayoresQue :: Ord a => a -> Tree a -> Bool
sonMayoresQue x EmptyT = True
sonMayoresQue x (NodeT y ti td) =
  y>x &&                  -- O(1)
  sonMayoresQue x ti &&   -- O(N)
  sonMayoresQue x td      -- O(N)

-- Propósito: dado un BST y un elemento, devuelve el máximo elemento que sea menor al
-- elemento dado.
-- Costo: O(costo elMaximoMenorAHA N)
-- Costo: O(log N)
-- Siendo N la cantidad de elementos del arbol
elMaximoMenorA :: Ord a => a -> Tree a -> Maybe a
elMaximoMenorA x t = elMaximoMenorAHA Nothing x t

-- Costo: O(log N)
-- Siendo N la cantidad de elementos del arbol
-- Y es log N porque en el peor caso se recorre una rama del arbol
-- lo cual corresponde con su altura.
elMaximoMenorAHA :: Ord a => Maybe a -> a -> Tree a -> Maybe a
elMaximoMenorAHA m x EmptyT = m
elMaximoMenorAHA m x (NodeT y ti td) =
  if y<x
    then elMaximoMenorAHA (Just y) x td
    else elMaximoMenorAHA m x ti

-- Propósito: dado un BST y un elemento, devuelve el mínimo elemento que sea mayor al
-- elemento dado.
-- Costo: O(costo elMinimoMayorAHA N)
-- Costo: O(log N)
-- siendo N la cantidad de elementos del arbol
elMinimoMayorA :: Ord a => a -> Tree a -> Maybe a
elMinimoMayorA x t = elMinimoMayorAHA Nothing x t

-- Costo: O(log N)
-- Siendo N la cantidad de elementos del arbol
-- Y es log N porque en el peor caso se recorre una rama del arbol
-- lo cual corresponde con su altura.
elMinimoMayorAHA :: Ord a => Maybe a -> a -> Tree a -> Maybe a
elMinimoMayorAHA m x EmptyT = m
elMinimoMayorAHA m x (NodeT y ti td) =
    if y>x
    then elMinimoMayorAHA (Just y) x ti
    else elMinimoMayorAHA m x td

-- Propósito: indica si el árbol está balanceado. Un árbol está balanceado cuando para cada
-- nodo la diferencia de alturas entre el subarbol izquierdo y el derecho es menor o igual a 1.
-- Costo: O([costo de heightT N]+[costo de heightT N]*N)
-- Costo: O((N+N)*N) = O((2N)*N) = O(2N^2)
 
-- ¿Se puede simplificar 2N^2 como N^2 o no?
-- Costo: O(N^2)
-- donde N la cantidad de elementos del arbol
balanceado :: Tree a -> Bool
balanceado EmptyT = True
balanceado (NodeT x ti td) =
  abs (heightT ti - heightT td) <= 1 && balanceado ti && balanceado td

-- Costo: O(n)
-- donde n es la cantidad de elementos del arbol
-- porque en cada instancia de la recursion solo se hace
-- operaciones constantes
heightT :: Tree a -> Int
heightT EmptyT = 0
heightT (NodeT _ t1 t2) = 1 + max (heightT t1) (heightT t2)



