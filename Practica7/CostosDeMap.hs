import Data.Maybe (fromJust)
import MapV1 ( Map, emptyM, assocM, lookupM, keys )
-- Ejercicio 3
-- -- Dada la siguiente interfaz y costos para el tipo abstracto Map:

-- data Map k v = M

-- -- Costo: O(1).
-- emptyM :: Map k v

-- -- Costo: O(log K).
-- assocM :: Ord k => k -> v -> Map k v -> Map k v

-- -- Costo: O(log K).
--lookupM :: Ord k => k -> Map k v -> Maybe v

-- Costo: O(log K).
-- deleteM :: Ord k => k -> Map k v -> Map k v
-- deleteM = undefined

-- Costo: O(K).
-- keys :: Map k v -> [k]
-- keys = undefined
-- recalcular el costo de las funciones como usuario de Map de la práctica anterior, siendo K es la
-- cantidad de claves del Map. Justificar las respuestas.

-- Costo: O([valuesKs (K, map)] + [keys (K)])
-- Costo: O([valuesKs K, map] + K)
-- Costo: O(K*LOG K + K)
-- Costo: O(K*LOG K)
-- Siendo K la cantidad de claves de m
valuesM :: Eq k => Map k v -> [Maybe v]
-- Propósito: obtiene los valores asociados a cada clave del map.
valuesM m = valuesKs (keys m) m

-- Suponemos que lookupM es costo O(log n)
-- Costo: O(L*[Costo lookupM (L, map)])
-- Costo: O(L*log M])
-- Siendo L la longitud de la lista
-- Siendo M la cantidad de claves del 
valuesKs :: Eq k => [k] -> Map k v-> [Maybe v]
valuesKs [] _ = []
valuesKs (k:ks) m = lookupM k m: valuesKs ks m

-- Suponemos que lookupM es costo O(log n)
-- Costo: O(K*[costo estaAsociada (L)])
-- Costo: O(K* Log L)
-- Siendo K la longitud de la lista
-- Siendo L la cantidad de elementos claves del map
todasAsociadas :: Eq k => [k] -> Map k v -> Bool
-- Propósito: indica si en el map se encuentran todas las claves dadas
todasAsociadas [] _ = True 
todasAsociadas (k: ks) m = estaAsociada k m && todasAsociadas ks m

-- Costo O(costo lookupM [L, map])
-- Costo O(log L)
-- Siendo L la cantidad de claves de m
estaAsociada :: Eq k => k -> Map k v -> Bool
estaAsociada k m = esJust (lookupM k m)

-- Costo : O(1)
esJust :: Maybe a -> Bool
esJust Nothing = False
esJust _ = True

-- suponemos que assocM cuesta O(log n)
-- Costo O(K*[costo assocM (K, map)])
-- Costo O(K* log L)
-- Costo O(K* log K)
-- Siendo K la longitud de la lista
-- Siendo L la cantida de claves del map
listToMap :: Eq k => [(k, v)] -> Map k v
-- Propósito: convierte una lista de pares clave valor en un map.
listToMap [] = emptyM
listToMap ((k,v): kvs) = assocM k v (listToMap kvs)

-- Suponemos que keys es O(N)
-- Costo O([costo mapToListKs (K, map)] + [costo keys (K)])
-- Costo O([costo mapToListKs (K, map)] + K)
-- Costo O(K*Log K+K) =O(K*Log K)
-- Siendo K la cantidad de claves del map
mapToList :: Eq k => Map k v -> [(k, v)]
-- Propósito: convierte un map en una lista de pares clave valor.
mapToList m = mapToListKs (keys m) m

-- Costo: O(L*[costo obtener (L, map)])
-- Costo: O(L*[Log R])
-- Siendo L la longitud de la lista
-- Siendo R la cantida de claves de m
mapToListKs :: Eq k => [k] -> Map k v -> [(k, v)]
mapToListKs [] _ = []
mapToListKs (k:ks) m = obtenerKV k m: mapToListKs ks m

-- Costo: O(costo valueM (R))
-- Costo: O(log R)
-- Siendo R la cantidad de claves del map
obtenerKV :: Eq k => k -> Map k v -> (k,v)
  -- Precondición la clave dada esta asociada a un valor en el map
obtenerKV k m = (k, valueM k m)

agruparEq :: Eq k => [(k, v)] -> Map k [v]
agruparEq [] = emptyM
agruparEq (kv:kvs) = agruparEqKV kv (agruparEq kvs)

agruparEqKV :: Eq k => (k, v) -> Map k [v] -> Map k [v]
agruparEqKV (k,v) m =
  if estaAsociada k m
    then assocM k (v:valueM k m) m
    else assocM k [v] m

-- suponemoes que lookupM es log n
-- Costo: O(lookup (S))
-- Costo: O(log S)
-- Siendo S la cantidad de claves del map
valueM :: Eq k => k -> Map k v -> v
-- Precond: k tiene un valor en el map
valueM k m = fromJust (lookupM k m)

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

-- Costo: O([costo listToMap K] + [costo indexarL K])
-- Costo: O(K + K^2)
-- Costo: O(K^2)
-- Costo: O(K + Log K)
indexar :: [a] -> Map Int a
-- Propósito: dada una lista de elementos construye un map que relaciona cada elemento con
-- su posición en la lista.
indexar xs = listToMap (indexarL xs)

type Index = Int

-- Costo: O(N*[costo aumentar N])
-- Costo: O(N*N) = O(N^2)
-- Siendo N la longitud de la lista
indexarL :: [a] -> [(Index,a)]
indexarL []     = []
indexarL (x:xs) = (0,x) : aumentar (indexarL xs)

-- Costo: O(M)
-- Siendo M la longitud de la lista
aumentar :: [(Index,a)] -> [(Index,a)]
-- aumenta todos los índices en uno
aumentar []          = []
aumentar ((i,x):ixs) = (i+1,x) : aumentar ixs

-- Costo: O(N*[assocOcurrencia (N map)])
-- Costo: O(N*2* Log N)
-- Siendo N la cantidad de elmentos de la lista, que a su vez
-- corresponde con la cantidad de claves del map
ocurrencias :: String -> Map Char Int
-- Propósito: dado un string, devuelve un map donde las claves son los caracteres que aparecen
-- en el string, y los valores la cantidad de veces que aparecen en el mismo.(*)
ocurrencias [] = emptyM 
ocurrencias (c:cs) = assocOcurrencia c (ocurrencias cs)

-- se supone que assocM es log n
-- Costo: O([costo assocM (M)] + [costo value (M)])
-- Costo: O([costo assocM (M)] + Log M)
-- Costo: O(Log M + Log M) = O(2 * Log M)
-- Siendo M la cantidad de claves del map
assocOcurrencia :: Char -> Map Char Int -> Map Char Int
assocOcurrencia c m =
  if estaAsociada c m
    then assocM c (valueM c m+1) m
    else assocM c 1 m
