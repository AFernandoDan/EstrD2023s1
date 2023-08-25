module MapV2 (Map, emptyM, assocM, lookupM, deleteM, keys) where

data Map k v = M [(k,v)]
{- Observacion: Al asociar el par se guarda en el principio de la lista
-}

-- O(1)
emptyM :: Map k v
-- Propósito: devuelve un map vacío
emptyM = M []

-- O(1)
assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una asociación clave-valor al map.
assocM k v (M kvs) = M ((k,v):kvs)

-- O(n)
lookupM :: Eq k => k -> Map k v -> Maybe v
-- Propósito: encuentra un valor dado una clave.
lookupM k (M kvs) = buscar k kvs

-- O(n)
buscar :: Eq k => k -> [(k,v)] -> Maybe v
buscar k [] = Nothing
buscar k ((k', v):kvs) =
  if k == k'
    then Just v
    else buscar k kvs

-- O(n)
deleteM :: Eq k => k -> Map k v -> Map k v
-- Propósito: borra una asociación dada una clave.
deleteM k (M kvs) = M (borrar k kvs)

-- O(n)
borrar :: Eq k => k -> [(k,v)] -> [(k,v)]
borrar k [] = []
borrar k ((k',v):kvs) =
  if k == k'
    then borrar k kvs
    else (k',v):borrar k kvs

-- O(n^2)
keys :: Eq k => Map k v -> [k]
-- Propósito: devuelve las claves del map.
keys (M kvs) = claves kvs

-- O(n^2)
claves :: Eq k => [(k,v)] -> [k]
claves [] = []
claves ((k,v):kvs) =
  if elem k (claves kvs)
    then claves kvs
    else k: claves kvs