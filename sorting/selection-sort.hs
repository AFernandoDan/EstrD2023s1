selectionSort :: (Ord a) => [a] -> [a]
selectionSort [] = []
selectionSort [x] = [x]
selectionSort (x:xs) =
  let (y, ys) = minList (x:xs)
  in y:selectionSort ys
-- costo: O(n^2), siendo n la longitud de la lista

minList :: (Ord a) => [a] -> (a, [a])
-- precond: la lista no es vacia
minList [] = error "empty list"
minList [x] = (x, [])
minList (x:xs) =
  let (y, ys) = minList xs
  in if x < y
    then (x, y:ys)
    else (y, x:ys)
-- costo: O(n), siendo n la longitud de la lista