-- O( [costo de collect K, map] + [costo de keys (K)])
-- ([costo de collect K, map] + K)
-- (k^2 + K)
-- donde K es la candidad de claves del multiset
multiSetToList :: MultiSet a -> [(a, Int)]

-- O(n * K)
-- donde n es la longitud de la lista
-- y K es la cantidad de claves del map
collect :: [k] -> Map k Int -> [(k, Int)]