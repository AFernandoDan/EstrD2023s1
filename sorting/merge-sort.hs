mergeSort :: (Ord a) => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = 
  let (ys, zs) = splitList xs
  in merge (mergeSort ys) (mergeSort zs)
-- sabiendo que splitList es O(n) y merge es O(k+s),
-- siendo k y s las longitudes de las listas
-- pero como k + s = n, entonces merge es O(n) y
-- que se hacen log(n) llamadas a merge, entonces
-- mergeSort es O(n*log(n))

merge :: (Ord a) => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x: xs) (y: ys) = 
  if x < y
    then x:merge xs (y: ys)
    else y:merge (x: xs) ys
-- costo: O(N+M), siendo N y M las longitudes de las listas{
-- ya que en el peor de los casos, se recorren ambas listas
-- en su totalidad y estas son de longitudes N y M respectivamente

splitList :: [a] -> ([a], [a])
splitList xs = splitListAux xs [] []
-- sabiendo que splitListAux es O(n), splitList es O(n)

splitListAux :: [a] -> [a] -> [a] -> ([a], [a])
splitListAux [] ys zs = (ys, zs)
splitListAux [x] ys zs = (x:ys, zs)
splitListAux (x:y:xs) ys zs = splitListAux xs (x:ys) (y:zs)
-- costo: O(n), siendo n la longitud de la lista
