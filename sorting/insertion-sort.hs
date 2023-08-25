-- 10 nums
nums = [5, 3, 2, 1, 4, 10, 9, 8, 7, 6]

insertionSort :: (Ord a) => [a] -> [a]
insertionSort [] = []
insertionSort (x: xs) = undirIS x (insertionSort xs)

-- precond: la lista no es vacia
undirIS :: (Ord a) => a -> [a] -> [a]
undirIS x [] = [x]
undirIS x (y:ys) = 
  if x > y
    then x:y:ys
    else y:undirIS x ys