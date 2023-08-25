import SetV1

-- 2. Set (conjunto)

singularSi :: a -> Bool -> [a]
singularSi x True  = x:[]
singularSi _ False = []

losQuePertenecen :: Eq a => [a] -> Set a -> [a]
losQuePertenecen [] s = []
losQuePertenecen (x: xs) s = singularSi x (belongsS x s) ++ losQuePertenecen xs s

sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos xs = setToList (listToSet xs)

listToSet :: Eq a => [a] -> Set a
listToSet [] = emptyS
listToSet (x:xs) = addS x (listToSet xs)

data Tree a = EmptyT | NodeT a (Tree a) (Tree a) deriving Show

unirTodos :: Eq a => Tree (Set a) -> Set a
unirTodos EmptyT = emptyS
unirTodos (NodeT s t1 t2) = unionS s (unionS (unirTodos t1) (unirTodos t2))

-- arbol de conjuntos de prueba
-- arbol1 :: Tree (Set Int)
arbol1 = NodeT (listToSet [1..10])
  (NodeT (listToSet [5..15]) EmptyT EmptyT)
  (NodeT (listToSet [30..40]) EmptyT EmptyT)