import MapV3
import Data.Maybe (fromJust)

-- ejemplo de map
mapEj = listToMap [("A",1), ("B",2), ("C",3), ("D",4), ("E",5)]

mapEj2 = listToMap [("A",10), ("C",30), ("F",3)]

-- Costo MapV1: O(n^2)
-- Costo MapV2: O(n^2)
valuesM :: Eq k => Map k v -> [Maybe v]
-- Propósito: obtiene los valores asociados a cada clave del map.
valuesM m = valuesKs (keys m) m

-- Costo MapV1: O(n^2)
-- Costo MapV2: O(N^2)
valuesKs :: Eq k => [k] -> Map k v-> [Maybe v]
valuesKs [] _ = []
valuesKs (k:ks) m = lookupM k m: valuesKs ks m

-- Costo MapV1: O(n^2)
-- Costo MapV2: O(N^2)
todasAsociadas :: Eq k => [k] -> Map k v -> Bool
-- Propósito: indica si en el map se encuentran todas las claves dadas
todasAsociadas [] _ = True 
todasAsociadas (k: ks) m = estaAsociada k m && todasAsociadas ks m

-- Costo MapV1: O(n)
-- Costo MapV2: O(N)
estaAsociada :: Eq k => k -> Map k v -> Bool
estaAsociada k m = esJust (lookupM k m)

-- Costo : O(1)
esJust :: Maybe a -> Bool
esJust Nothing = False
esJust _ = True

-- Costo MapV1: O(n^2)
-- Costo MapV2: O(n)
listToMap :: Eq k => [(k, v)] -> Map k v
-- Propósito: convierte una lista de pares clave valor en un map.
listToMap [] = emptyM
listToMap ((k,v): kvs) = assocM k v (listToMap kvs)

-- Costo MapV1: O(n^2)
-- Costo MapV2: O(N^2)
mapToList :: Eq k => Map k v -> [(k, v)]
-- Propósito: convierte un map en una lista de pares clave valor.
mapToList m = mapToListKs (keys m) m

-- Costo MapV1: O(n^2)
-- Costo MapV2: O(N^2)
mapToListKs :: Eq k => [k] -> Map k v -> [(k, v)]
mapToListKs [] _ = []
mapToListKs (k:ks) m = obtenerKV k m: mapToListKs ks m

-- Costo MapV1: O(n)
-- Costo MapV2: O(N)
obtenerKV :: Eq k => k -> Map k v -> (k,v)
  -- Precondición la clave dada esta asociada a un valor en el map
obtenerKV k m = (k, valueM k m)

-- Costo MapV1: O(n^2)
-- Costo MapV2: O(N^2)
agruparEq :: Eq k => [(k, v)] -> Map k [v]
agruparEq [] = emptyM
agruparEq (kv:kvs) = agruparEqKV kv (agruparEq kvs)

-- Costo MapV1: O(n)
-- Costo MapV2: O(N)
agruparEqKV :: Eq k => (k, v) -> Map k [v] -> Map k [v]
agruparEqKV (k,v) m =
  if estaAsociada k m
    then assocM k (v:valueM k m) m
    else assocM k [v] m

-- Costo MapV1: O(n)
-- Costo MapV2: O(N)
valueM :: Eq k => k -> Map k v -> v
-- Precond: k tiene un valor en el map
valueM k m = fromJust (lookupM k m)

-- Costo MapV1: O(n^2)
-- Costo MapV2: O(N^2)
incrementar :: Eq k => [k] -> Map k Int -> Map k Int
incrementar [] m = m
incrementar (k: ks) m = incrementarVSiK k (incrementar ks m)

-- Costo MapV1: O(n)
-- Costo MapV2: O(N)
incrementarVSiK :: Eq k => k -> Map k Int -> Map k Int
incrementarVSiK k m =
  if estaAsociada k m
    then assocM k (valueM k m+1) m
    else m

-- Costo MapV1: O(n^2)
-- Costo MapV2: O(N^2)
mergeMaps :: Eq k => Map k v -> Map k v -> Map k v
mergeMaps m1 m2 = mergeMapsKs (keys m1) m1 m2

-- Costo MapV1: O(n^2)
-- Costo MapV2: O(N^2)
-- Costo MapV2: O(M1*2*(M1+M2)), M1 = length ks = los elementos de la estructura de m1
--                               M2 = los elementos de la estructura de m2
-- O(m1*2*(m1+m2)) = O(m1*(m1+m2)) = O(m1^2+m1*m2)
mergeMapsKs :: Eq k => [k] -> Map k v -> Map k v -> Map k v
mergeMapsKs [] m1 m2 = m2
mergeMapsKs (k:ks) m1 m2 = assocM k (valueM k m1) (mergeMapsKs ks m1 m2)

-- Costo MapV1: O(n^2)
-- Costo MapV2: O(n^2)
indexar :: [a] -> Map Int a
-- Propósito: dada una lista de elementos construye un map que relaciona cada elemento con
-- su posición en la lista.
indexar xs = listToMap (indexarL xs)

type Index = Int

-- Costo: O(n^2)
indexarL :: [a] -> [(Index,a)]
indexarL []     = []
indexarL (x:xs) = (0,x) : aumentar (indexarL xs)

-- Costo: O(n)
aumentar :: [(Index,a)] -> [(Index,a)]
-- aumenta todos los índices en uno
aumentar []          = []
aumentar ((i,x):ixs) = (i+1,x) : aumentar ixs

-- Costo MapV1: O(n^2)
-- Costo MapV2: O(N^2)
ocurrencias :: String -> Map Char Int
-- Propósito: dado un string, devuelve un map donde las claves son los caracteres que aparecen
-- en el string, y los valores la cantidad de veces que aparecen en el mismo.(*)
ocurrencias [] = emptyM 
ocurrencias (c:cs) = assocOcurrencia c (ocurrencias cs)

-- Costo MapV1: O(n)
-- Costo MapV2: O(N)
assocOcurrencia :: Char -> Map Char Int -> Map Char Int
assocOcurrencia c m =
  if estaAsociada c m
    then assocM c ((valueM c m)+1) m
    else assocM c 1 m