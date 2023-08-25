import PriorityQueue

-- O(n^2)
heapSort :: Ord a => [a] -> [a]
heapSort xs = pqToList (listToPQ xs)

-- O(n^2)
-- calculo de costo con una PQ implementada en un Heap
-- (costo emptyPq) + K * (insertPQ K)
--        1        + K *    Log K
-- Costo: O(K*LogK)
listToPQ :: Ord a => [a] -> PriorityQueue a
listToPQ [] = emptyPQ
listToPQ (x:xs) = insertPQ x (listToPQ xs)

-- O(n)
pqToList :: Ord a => PriorityQueue a -> [a]
pqToList pq =
  if isEmptyPQ pq
    then []
    else findMinPQ pq: pqToList (deleteMinPQ pq)