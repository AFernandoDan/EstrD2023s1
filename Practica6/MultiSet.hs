module MultiSet (MultiSet, emptyMS, addMS, ocurrencesMS, unionMS, intersectionMS, multiSetToList) where 
import MapV1
import Data.Maybe (fromJust)

data MultiSet a = MS (Map a Int)

-- costo: O(1)
emptyMS :: MultiSet a
-- Propósito: denota un multiconjunto vacío.
emptyMS = MS emptyM

-- costo:
addMS :: Ord a => a -> MultiSet a -> MultiSet a
-- Propósito: dados un elemento y un multiconjunto, agrega una ocurrencia de ese elemento al
-- multiconjunto.
addMS k (MS m) = MS (incrementarSiKSinoUno k m)

incrementarSiKSinoUno :: Eq k => k -> Map k Int -> Map k Int
incrementarSiKSinoUno k m = if estaAsociada k m then incrementarV k m else assocM k 1 m

incrementarV :: Eq k => k -> Map k Int -> Map k Int
-- Precond: Debe estar asociada k en el map
incrementarV k m = assocM k (valueM k m+1) m

valueM :: Eq k => k -> Map k v -> v
-- Precond: k tiene un valor en el map
valueM k m = fromJust (lookupM k m)

estaAsociada :: Eq k => k -> Map k v -> Bool
estaAsociada k m = esJust (lookupM k m)

esJust :: Maybe a -> Bool
esJust Nothing = False
esJust _ = True

ocurrencesMS :: Ord a => a -> MultiSet a -> Int
-- Propósito: dados un elemento y un multiconjunto indica la cantidad de apariciones de ese
-- elemento en el multiconjunto.
ocurrencesMS k (MS m) = valueMSiKSinoCero k m

valueMSiKSinoCero k m =
  if estaAsociada k m
    then valueM k m
    else 0

unionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a -- (opcional)
-- Propósito: dados dos multiconjuntos devuelve un multiconjunto con todos los elementos de
-- ambos multiconjuntos.
unionMS (MS m1) (MS m2) = MS (unionMS' (keys m1) m1 m2)

-- unionMS' :: Ord k => [k] -> Map k Int -> Map k Int -> Map k Int
-- unionMS' [] m1 m2 = m2
-- unionMS' (x:xs) m1 m2 = unificarV x m1 (unionMS' xs m1 m2)

unionMS' :: Ord k => [k] -> Map k Int -> Map k Int -> Map k Int
unionMS' [] m1 m2 = m2
unionMS' (k:ks) m1 m2 = unificarV k (valueM k m1) (unionMS' ks m1 m2)

unificarV :: Ord k => k -> Int -> Map k Int -> Map k Int
unificarV k n m = case lookupM k m of
                   Just n2 -> assocM k (n+n2) m
                   Nothing -> assocM k n m

-- unificarV :: Ord k => k -> Map k Int -> Map k Int -> Map k Int
-- unificarV k m1 m2 = assocM k (valueMSiKSinoCero k m2 + valueM k m1) m2 

intersectionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a -- (opcional)
-- Propósito: dados dos multiconjuntos devuelve el multiconjunto de elementos que ambos
-- multiconjuntos tienen en común.
intersectionMS (MS m1) (MS m2) = MS (intersectionMS' (keys m1) m1 m2)

intersectionMS' :: Ord k => [k] -> Map k Int -> Map k Int -> Map k Int
intersectionMS' [] m1 m2 = m2
intersectionMS' (k:ks) m1 m2 = assocInterseccionM k (valueM k m1) (intersectionMS' ks m1 m2)

assocInterseccionM :: Ord k => k -> Int -> Map k Int -> Map k Int
assocInterseccionM k v m = case lookupM k m of
                   Just v2 -> assocM k (min v v2) m
                   Nothing -> m

-- Costo
multiSetToList :: Eq a => MultiSet a -> [(a, Int)]
-- Propósito: dado un multiconjunto devuelve una lista con todos los elementos del conjunto y
-- su cantidad de ocurrencias.
multiSetToList (MS m) = mapToList m

-- Costo MapV1: O(n^2)
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