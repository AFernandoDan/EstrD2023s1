data Pizza = Prepizza
  | Capa Ingrediente Pizza deriving Show

data Ingrediente = Salsa
  | Queso
  | Jamon
  | Aceitunas Int deriving Show

-- pizza de pruebas
pizza1 :: Pizza
pizza1 = Capa Salsa (Capa Queso (Capa Jamon (Capa (Aceitunas 3) Prepizza)))

pizza2 :: Pizza
pizza2 = Capa Salsa (Capa Queso (Capa (Aceitunas 10) Prepizza))

pizza3 :: Pizza
pizza3 = Capa Queso (Capa Queso (Capa Salsa Prepizza))

pizzas :: [Pizza]
pizzas = [pizza1, pizza2, pizza3]

cantidadDeCapas :: Pizza -> Int
cantidadDeCapas Prepizza = 0
cantidadDeCapas (Capa _ p) = 1 + cantidadDeCapas p

armarPizza :: [Ingrediente] -> Pizza
armarPizza [] = Prepizza
armarPizza (i: is) = Capa i (armarPizza is)

sacarJamon :: Pizza -> Pizza
sacarJamon Prepizza = Prepizza
sacarJamon (Capa i p) =
  if esJamon i
    then sacarJamon p
    else (Capa i (sacarJamon p))

esJamon :: Ingrediente -> Bool
esJamon Jamon = True
esJamon _ = False

tieneSoloSalsaYQueso :: Pizza -> Bool
tieneSoloSalsaYQueso Prepizza = True
tieneSoloSalsaYQueso (Capa i p) = esSalsaOQueso i && tieneSoloSalsaYQueso p

esSalsaOQueso :: Ingrediente -> Bool
esSalsaOQueso Queso = True
esSalsaOQueso Salsa = True
esSalsaOQueso _ = False

duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza = Prepizza
duplicarAceitunas (Capa i p) = Capa (duplicarAceitunasI i)(duplicarAceitunas p)

duplicarAceitunasI :: Ingrediente -> Ingrediente
duplicarAceitunasI (Aceitunas i) = Aceitunas (2*i)
duplicarAceitunasI i = i

cantCapasPorPizza :: [Pizza] -> [(Int, Pizza)]
cantCapasPorPizza [] = []
cantCapasPorPizza (p: ps) = (cantidadDeCapas p, p):cantCapasPorPizza ps

data Dir = Izq | Der deriving Show
data Objeto = Tesoro | Chatarra deriving Show
data Cofre = Cofre [Objeto] deriving Show
data Mapa = Fin Cofre
  | Bifurcacion Cofre Mapa Mapa deriving Show

-- mapa de pruebas
mapa1 :: Mapa
mapa1 = Bifurcacion (Cofre [Tesoro, Chatarra])
  (Fin (Cofre [Chatarra, Chatarra, Tesoro]))
  (Bifurcacion (Cofre [Chatarra, Chatarra])
    (Fin (Cofre [Chatarra, Chatarra]))
    (Fin (Cofre [Tesoro, Chatarra])))

mapaConUnTesoro :: Mapa
mapaConUnTesoro = Bifurcacion (Cofre [Chatarra, Chatarra])
  (Fin (Cofre [Chatarra, Chatarra]))
  (Bifurcacion (Cofre [Chatarra, Chatarra])
    (Fin (Cofre [Chatarra, Chatarra]))
    (Fin (Cofre [Chatarra, Tesoro])))

hayTesoro :: Mapa -> Bool
hayTesoro (Fin c) = hayTesoroC c
hayTesoro (Bifurcacion c m1 m2) = hayTesoroC c || hayTesoro m1 || hayTesoro m2

hayTesoroC :: Cofre -> Bool
hayTesoroC (Cofre os) = hayTesoroO os

hayTesoroO :: [Objeto] -> Bool
hayTesoroO [] = False
hayTesoroO (o: os) = esTesoro o || hayTesoroO os

esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro _ = False

hayTesoroEn :: [Dir] -> Mapa -> Bool
hayTesoroEn [] m = hayTesoroC (cofreM m)
hayTesoroEn (d: ds) (Fin c) = False
hayTesoroEn (d: ds) (Bifurcacion _ m1 m2) = 
  if esIzq d
    then hayTesoroEn ds m1
    else hayTesoroEn ds m2

cofreM :: Mapa -> Cofre
cofreM (Fin c) = c
cofreM (Bifurcacion c _ _) = c

esIzq :: Dir -> Bool
esIzq Izq = True
esIzq _ = False

caminoAlTesoro :: Mapa -> [Dir]
  -- Precondición: existe un tesoro y es único.
caminoAlTesoro (Fin c) = []
caminoAlTesoro (Bifurcacion c m1 m2) =
  if hayTesoroC c
    then [] 
    else if hayTesoro m1
      then Izq: caminoAlTesoro m1
      else Der: caminoAlTesoro m2

caminoDeLaRamaMasLarga :: Mapa -> [Dir]
caminoDeLaRamaMasLarga (Fin _) = []
caminoDeLaRamaMasLarga (Bifurcacion _ m1 m2) =
  if length (caminoDeLaRamaMasLarga m1) > length (caminoDeLaRamaMasLarga m2)
    then Izq:caminoDeLaRamaMasLarga m1
    else Der:caminoDeLaRamaMasLarga m2

tesorosPorNivel :: Mapa -> [[Objeto]]
tesorosPorNivel (Fin c) = [tesorosC c]
tesorosPorNivel (Bifurcacion c m1 m2) = tesorosC c : juntarNiveles (tesorosPorNivel m1) (tesorosPorNivel m2)

juntarNiveles :: [[a]] -> [[a]] -> [[a]]
juntarNiveles []       yss      = yss
juntarNiveles xss      []       = xss
juntarNiveles (xs:xss) (ys:yss) = (xs ++ ys) : juntarNiveles xss yss

tesorosC :: Cofre -> [Objeto]
tesorosC (Cofre os) = tesorosO os

tesorosO :: [Objeto] -> [Objeto]
tesorosO [] = []
tesorosO (o: os) = singularSi o (esTesoro o)++ tesorosO os

singularSi :: a -> Bool -> [a]
singularSi x True  = x:[]
singularSi _ False = []

todosLosCaminos :: Mapa -> [[Dir]]
todosLosCaminos (Fin _) = [[]]
todosLosCaminos (Bifurcacion _ m1 m2) =
  consACada Izq (todosLosCaminos m1) ++ consACada Der (todosLosCaminos m2)

consACada :: a -> [[a]] -> [[a]]
consACada x [] = []
consACada x (xs: xss) = (x: xs): consACada x xss

data Componente = LanzaTorpedos | Motor Int | Almacen [Barril] deriving Show
data Barril = Comida | Oxigeno | Torpedo | Combustible deriving Show
data Sector = S SectorId [Componente] [Tripulante] deriving Show
type SectorId = String
type Tripulante = String
data Tree a = EmptyT | NodeT a (Tree a) (Tree a) deriving Show
data Nave = N (Tree Sector) deriving Show

-- naves de prueba
nave1 :: Nave
nave1 = N (NodeT (S "1" [Motor 1, Almacen [Comida, Oxigeno, Torpedo, Combustible]] ["Menganito"])
  (NodeT (S "2" [Motor 2, Almacen [Comida, Oxigeno, Torpedo, Combustible]] ["Juanito"])
    (NodeT (S "3" [Motor 3, Almacen [Comida, Oxigeno, Torpedo, Combustible]] ["Pedrito"])
      EmptyT
      EmptyT)
    EmptyT)
  EmptyT)

nave2 :: Nave
nave2 = N (NodeT (S "1" [Motor 1, Almacen [Comida, Oxigeno, Torpedo, Combustible]] ["Pepito"])
  (NodeT (S "2" [Motor 2, Almacen [Comida, Oxigeno, Torpedo, Combustible]] ["Juanito"])
    (NodeT (S "3" [Motor 3, Almacen [Comida, Oxigeno, Torpedo, Combustible]] ["Pedrito"])
      EmptyT
      EmptyT)
    EmptyT)
  (NodeT (S "4" [Motor 4, Almacen [Comida, Oxigeno, Torpedo, Combustible]] ["Pepito"])
    (NodeT (S "5" [Motor 5, Almacen [Comida, Oxigeno, Torpedo, Combustible]] ["Juanito"])
      (NodeT (S "6" [Motor 6, Almacen [Combustible, Combustible, Combustible, Combustible]] ["Pedrito"])
        EmptyT
        EmptyT)
      EmptyT)
    EmptyT))

sectores :: Nave -> [SectorId]
sectores (N t) = sectoresT t

sectoresT :: Tree Sector -> [SectorId]
sectoresT EmptyT = []
sectoresT (NodeT s t1 t2) = idSector s: sectoresT t1 ++ sectoresT t2

idSector :: Sector -> SectorId
idSector (S id _ _) = id

poderDePropulsion :: Nave -> Int
poderDePropulsion (N t) = poderDePropulsionT t

poderDePropulsionT :: Tree Sector -> Int
poderDePropulsionT EmptyT = 0
poderDePropulsionT (NodeT s t1 t2) =
  poderDePropulsionS s + poderDePropulsionT t1 + poderDePropulsionT t2

poderDePropulsionS :: Sector -> Int
poderDePropulsionS s = poderDePropulsionCs (componentesS s)

poderDePropulsionCs :: [Componente] -> Int
poderDePropulsionCs [] = 0
poderDePropulsionCs (c: cs) = poderDePropulsionC c + poderDePropulsionCs cs

poderDePropulsionC :: Componente -> Int
poderDePropulsionC (Motor p) = p
poderDePropulsionC _ = 0

barriles :: Nave -> [Barril]
barriles (N t) = barrilesT t

barrilesT :: Tree Sector -> [Barril]
barrilesT EmptyT = []
barrilesT (NodeT s t1 t2) = barrilesS s ++ barrilesT t1 ++ barrilesT t2

barrilesS :: Sector -> [Barril]
barrilesS s = barrilesCs (componentesS s)

componentesS :: Sector -> [Componente]
componentesS (S _ cs _) = cs

barrilesCs :: [Componente] -> [Barril]
barrilesCs [] = []
barrilesCs (c: cs) = barrilesC c ++ barrilesCs cs

barrilesC :: Componente -> [Barril]
barrilesC (Almacen bs) = bs
barrilesC _ = []

agregarASector :: [Componente] -> SectorId -> Nave -> Nave
agregarASector cs id (N t) = N (agregarASectorT cs id t)

agregarASectorT :: [Componente] -> SectorId -> Tree Sector -> Tree Sector
agregarASectorT cs id EmptyT = EmptyT
agregarASectorT cs id (NodeT s t1 t2) =
  if tieneId id s
    then NodeT (agregarASectorS cs s) t1 t2
    else NodeT s (agregarASectorT cs id t1) (agregarASectorT cs id t2)

tieneId :: SectorId -> Sector -> Bool
tieneId id1 (S id2 _ _) = id1 == id2

agregarASectorS :: [Componente] -> Sector -> Sector
agregarASectorS cs1 (S id cs2 ts) = S id (cs1++cs2) ts

asignarTripulanteA :: Tripulante -> [SectorId] -> Nave -> Nave
  -- Todos los id de la lista existen en la nave.
asignarTripulanteA tr ss (N t) = N (asignarTripulanteAT tr ss t)

asignarTripulanteAT :: Tripulante -> [SectorId] -> Tree Sector -> Tree Sector
asignarTripulanteAT t ss EmptyT = EmptyT
asignarTripulanteAT t ss (NodeT s t1 t2) =
  NodeT (asignarTSiCorrespondeAS t ss s)
    (asignarTripulanteAT t ss t1)
    (asignarTripulanteAT t ss t2)

asignarTSiCorrespondeAS :: Tripulante -> [SectorId] -> Sector -> Sector
asignarTSiCorrespondeAS t ss s =
  if pertenece (idSector s) ss && not (estaEnSectorS t s)
    then asignarTripulanteAS t s
    else s

asignarTripulanteAS :: Tripulante -> Sector -> Sector
asignarTripulanteAS t (S id cs ts) = S id cs (t:ts)

estaEnSectorS :: Tripulante -> Sector -> Bool
estaEnSectorS t (S _ _ ts) = pertenece t ts

pertenece :: Eq a => a -> [a] -> Bool
pertenece e [] = False
pertenece e (x:xs) = e==x || pertenece e xs

sectoresAsignados :: Tripulante -> Nave -> [SectorId]
sectoresAsignados tr (N t) = sectoresAsignadosT tr t

sectoresAsignadosT :: Tripulante -> Tree Sector -> [SectorId]
sectoresAsignadosT t EmptyT = []
sectoresAsignadosT t (NodeT s t1 t2) =
  singularSi (idSector s) (estaEnSectorS t s)
  ++ sectoresAsignadosT t t1
  ++ sectoresAsignadosT t t2

tripulantes :: Nave -> [Tripulante]
tripulantes (N t) = sinRepetidos (tripulantesConRepetidosT t)

sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos [] = []
sinRepetidos (x: xs) =
  singularSi x (not (pertenece x xs)) ++ sinRepetidos xs

tripulantesConRepetidosT :: Tree Sector -> [Tripulante]
tripulantesConRepetidosT EmptyT = []
tripulantesConRepetidosT (NodeT s t1 t2) =
  tripulantesS s ++ tripulantesConRepetidosT t1 ++ tripulantesConRepetidosT t2

tripulantesS :: Sector -> [Tripulante]
tripulantesS (S _ _ ts) = ts

type Presa = String -- nombre de presa
type Territorio = String -- nombre de territorio
type Nombre = String -- nombre de lobo
data Lobo = Cazador Nombre [Presa] Lobo Lobo Lobo
  | Explorador Nombre [Territorio] Lobo Lobo
  | Cria Nombre deriving Show
data Manada = M Lobo deriving Show

manada1 :: Manada
manada1 = M (Cazador "Cazador1" ["Presa1", "Presa2", "Presa3", "Presa4", "Presa5", "Presa6"]
            (Explorador "Explorador1" ["Territorio1", "Territorio2"]
              (Cria "Cría1") (Cria "Cría2"))
            (Explorador "Explorador2" ["Territorio2", "Territorio4"]
              (Cria "Cría3") (Cria "Cría4"))
            (Cria "Cría5"))

manadaConVariosCazadores :: Manada
manadaConVariosCazadores = M (Cazador "Cazador1" ["Presa1"]
            (Cazador "Cazador4" ["Presa"]
              (Cria "Cría1") (Cria "Cría2") (Cria "Cría3"))
            (Explorador "Explorador2" ["Territorio2", "Territorio4"]
              (Cria "Cría3") (Cria "Cría4"))
            (Cria "Cría5"))

buenaCaza :: Manada -> Bool
buenaCaza m = alimentoCazado m > cantidadCrias m

alimentoCazado :: Manada -> Int
alimentoCazado (M l) = alimentoCazadoL l

alimentoCazadoL :: Lobo -> Int
alimentoCazadoL (Cazador _ ps l1 l2 l3) =
  cantPresasPs ps + alimentoCazadoL l1 + alimentoCazadoL l2 + alimentoCazadoL l3
alimentoCazadoL (Explorador _ _ l1 l2) =
  alimentoCazadoL l1 + alimentoCazadoL l2
alimentoCazadoL (Cria _) = 0

cantPresasPs :: [Presa] -> Int
cantPresasPs ps = length ps

cantidadCrias :: Manada -> Int
cantidadCrias (M l) = cantidadCriasL l

cantidadCriasL :: Lobo -> Int
cantidadCriasL (Cazador _ _ l1 l2 l3) =
  cantidadCriasL l1 + cantidadCriasL l2 + cantidadCriasL l3
cantidadCriasL (Explorador _ _ l1 l2) =
  cantidadCriasL l1 + cantidadCriasL l2
cantidadCriasL (Cria _) = 1

elAlfa :: Manada -> (Nombre, Int)
elAlfa (M l) = elAlfaL l

elAlfaL :: Lobo -> (Nombre, Int)
elAlfaL (Cazador nom ps l1 l2 l3) =
  elegir (nom, cantPresasPs ps)
    (elegir (elAlfaL l1)
      (elegir (elAlfaL l2) (elAlfaL l3)))
elAlfaL (Explorador nom _ l1 l2) =
  elegir (elAlfaL l1)
    (elegir (elAlfaL l2) (nom, 0))
elAlfaL (Cria nom) = (nom, 0)

elegir :: (Nombre, Int) -> (Nombre, Int) -> (Nombre, Int)
elegir (n1, c1) (n2, c2) =
  if c1 >= c2
    then (n1, c1)
    else (n2, c2)

losQueExploraron :: Territorio -> Manada -> [Nombre]
losQueExploraron t (M l) = losQueExploraronL t l

losQueExploraronL :: Territorio -> Lobo -> [Nombre]
losQueExploraronL t (Cria _) = []
losQueExploraronL t (Cazador _ _ l1 l2 l3) =
  losQueExploraronL t l1 ++ losQueExploraronL t l2
losQueExploraronL t (Explorador n ts l1 l2) =
  singularSi n (pertenece t ts) ++ losQueExploraronL t l1 ++ losQueExploraronL t l2

exploradoresPorTerritorio :: Manada -> [(Territorio, [Nombre])]
exploradoresPorTerritorio (M l) = exploradoresPorTerritorioL l

exploradoresPorTerritorioL :: Lobo -> [(Territorio, [Nombre])]
exploradoresPorTerritorioL (Cria _) = []
exploradoresPorTerritorioL (Cazador _ _ l1 l2 l3) =
  unificarTerritorios
    (exploradoresPorTerritorioL l1)
    (unificarTerritorios
      (exploradoresPorTerritorioL l2)
      (exploradoresPorTerritorioL l3))
exploradoresPorTerritorioL (Explorador n ts l1 l2) =
  unificarTerritorios
    (exploradoresPorTerritorioTs n ts)
    (unificarTerritorios
      (exploradoresPorTerritorioL l1)
      (exploradoresPorTerritorioL l2))

unificarTerritorios :: [(Territorio, [Nombre])] -> [(Territorio, [Nombre])] -> [(Territorio, [Nombre])]
unificarTerritorios [] ys = ys
unificarTerritorios (x: xs) ys = agregarALosTerritorios x (unificarTerritorios xs ys)

agregarALosTerritorios :: (Territorio, [Nombre]) -> [(Territorio, [Nombre])] -> [(Territorio, [Nombre])]
agregarALosTerritorios x [] = [x]
agregarALosTerritorios x (y: ys) = 
  if fst x == fst y
    then (fst x, snd x ++ snd y):ys
    else y:agregarALosTerritorios x ys

exploradoresPorTerritorioTs :: Nombre -> [Territorio] -> [(Territorio, [Nombre])]
exploradoresPorTerritorioTs n [] = []
exploradoresPorTerritorioTs n (t:ts) = (t, [n]): exploradoresPorTerritorioTs n ts

superioresDelCazador :: Nombre -> Manada -> [Nombre]
  -- Precondición: hay un cazador con dicho nombre y es único.
superioresDelCazador n (M l) = superioresDelCazadorL n l

superioresDelCazadorL :: Nombre -> Lobo -> [Nombre]
  -- Precondición: hay un cazador con dicho nombre y es único.
superioresDelCazadorL n1 (Cazador n2 ts l1 l2 l3) =
  if algunoEsSuperior n1 [l1,l2,l3]
    then n2:superioresDelCazadorL n1 l1 ++
            superioresDelCazadorL n1 l2 ++
            superioresDelCazadorL n1 l3
    else []
superioresDelCazadorL n1 (Explorador _ _ l1 l2) =
  superioresDelCazadorL n1 l1 ++ superioresDelCazadorL n1 l2
superioresDelCazadorL _ (Cria _) = []

algunoEsSuperior :: Nombre -> [Lobo] -> Bool
algunoEsSuperior n [] = False
algunoEsSuperior n (l:ls) = esSuperiorDeL n l || algunoEsSuperior n ls

esSuperiorDeL :: Nombre -> Lobo -> Bool
esSuperiorDeL n1 (Cazador n2 _ l1 l2 l3) =
  n1 == n2 || esSuperiorDeL n1 l1 || esSuperiorDeL n1 l2 || esSuperiorDeL n1 l3
esSuperiorDeL n1 (Explorador _ _ l1 l2) =
  esSuperiorDeL n1 l1 || esSuperiorDeL n1 l2
esSuperiorDeL n1 (Cria _) = False