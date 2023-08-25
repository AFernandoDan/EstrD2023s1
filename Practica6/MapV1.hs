module MapV1 (Map, emptyM, assocM, lookupM, deleteM, keys) where

data Map k v = M [(k,v)]
{-  INV.REP: En M xs, se cumple que en xs no hay dos pares (k,v) con la misma clave k
    VALIDA:
      M []
      M [("A",1)]
      M [("A",1), ("B",2)]
    INVALIDO:
      M [("A",1), ("A",2)]
  
-}

-- O(1)
emptyM :: Map k v
-- Propósito: devuelve un map vacío
emptyM = M []

-- O(n)
assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una asociación clave-valor al map.
assocM k v (M kvs) = M (asociar k v kvs)

-- O(n)
asociar :: Eq k => k -> v -> [(k,v)] -> [(k,v)]
asociar k v [] = [(k,v)]
asociar k v ((k',v'):kvs) =
  if k == k'
    then (k,v):kvs
    else (k',v'):asociar k v kvs

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
    then kvs
    else (k',v):borrar k kvs

-- O(n)
keys :: Map k v -> [k]
-- Propósito: devuelve las claves del map.
keys (M kvs) = claves kvs

-- O(n)
claves :: [(k,v)] -> [k]
claves [] = []
claves ((k,v):kvs) = k: claves kvs