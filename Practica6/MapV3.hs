module MapV3 (Map, emptyM, assocM, lookupM, deleteM, keys) where

data Map k v = M [k] [v]
{-  INV.REP: En M ks vs, se cumple que en ks no hay dos k iguales, ademas ambas listas tienen la misma longitud
    VALIDA:
      M [] []
      M ['a'] [1]
      M ['a', 'b'] [1,2]
    INVALIDO:
      M ['a', 'a'] [1,2]
      M [] [1]
      M ['a'] []
  
-}

-- O(1)
emptyM :: Map k v
-- Propósito: devuelve un map vacío
emptyM = M [] []

-- O(n)
assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una asociación clave-valor al map.
assocM k' v' (M ks vs) = let (nks, nvs) = assocM' k' v' ks vs in M nks nvs

-- O(n)
assocM' :: Eq k => k -> v -> [k] -> [v] -> ([k],[v])
assocM' k' v' [] _ = ([k'], [v'])
assocM' k' v' (k:ks) (v:vs) =
  if k'== k
    then (k:ks, v':vs)
    else let (nks, nvs) = assocM' k' v' ks vs in (k:nks, v:nvs)

-- O(n)
lookupM :: Eq k => k -> Map k v -> Maybe v
-- Propósito: encuentra un valor dado una clave.
lookupM k' (M ks vs) = buscarLL k' ks vs

-- O(n)
buscarLL :: Eq k => k -> [k] -> [v] -> Maybe v
buscarLL k' [] _ = Nothing
buscarLL k' (k:ks) (v:vs) =
  if k == k'
    then Just v
    else buscarLL k' ks vs

-- O(n)
deleteM :: Eq k => k -> Map k v -> Map k v
-- Propósito: borra una asociación dada una clave.
deleteM k' (M ks vs) = let (nks, nvs) = deleteM' k' ks vs in M nks nvs

-- O(n)
deleteM' :: Eq k => k -> [k] -> [v] -> ([k],[v])
deleteM' k' [] _ = ([],[])
deleteM' k' (k:ks) (v:vs) =
  if k' == k
    then (ks,vs)
    else let (nks, nvs) = deleteM' k' ks vs in (k:nks, v:nvs)

-- O(1)
keys :: Map k v -> [k]
-- Propósito: devuelve las claves del map.
keys (M ks _) = ks