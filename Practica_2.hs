-- 1 - Recursion sobre listas

-- 1.1 sumatoria
sumatoria :: [Int] -> Int
sumatoria [] = 0
sumatoria (x:xs) = x + sumatoria xs

-- 1.2 longitud
longitud :: [a] -> Int
longitud [] = 0
longitud (x:xs) = 1 + longitud xs

-- 1.3 sucesores

-- Subtarea necesaria de la practica 1
sucesor :: Int -> Int
sucesor x = x + 1

sucesores :: [Int] -> [Int]
sucesores [] = []
sucesores (x:xs) = sucesor x :sucesores xs

-- 1.4 conjuncion
conjuncion :: [Bool] -> Bool
conjuncion [] = False
conjuncion (x:[]) = x
conjuncion (x:xs) = x && conjuncion xs

-- 1.5 disyuncion
disyuncion :: [Bool] -> Bool
disyuncion [] = False
disyuncion (x:xs) = x || disyuncion xs

-- 1.6 aplanar

-- Subtarea necesaria: agregar
agregar :: [a] -> [a] -> [a]
agregar [] ys = ys
agregar (x:xs) ys = x :agregar xs ys

aplanar :: [[a]] -> [a]
aplanar [] = []
aplanar (x: xs) = agregar x (aplanar xs)

-- 1.7 pertenece
pertenece :: Eq a => a -> [a] -> Bool
pertenece e [] = False
pertenece e (x:xs) = e==x || pertenece e xs

-- 1.8 apariciones
apariciones :: Eq a => a -> [a] -> Int
apariciones e [] = 0
apariciones e (x:xs) = if e==x
                        then 1 + apariciones e xs
                        else apariciones e xs

-- 1.9 losMenoresA
losMenoresA :: Int -> [Int] -> [Int]
losMenoresA n [] = []
losMenoresA n (x:xs) = if x<n
                      then x:losMenoresA n xs
                      else losMenoresA n xs

-- 1.10 lasDeLongitudMayorA 
lasDeLongitudMayorA :: Int -> [[a]] -> [[a]]
lasDeLongitudMayorA n [] = []
lasDeLongitudMayorA n (x:xs) = if length x > n
                                then x: lasDeLongitudMayorA n xs
                                else lasDeLongitudMayorA n xs

-- 1.11 agregarAlFinal
agregarAlFinal :: [a] -> a -> [a]
agregarAlFinal [] e = [e]
agregarAlFinal (x:xs) e = x: agregarAlFinal xs e

-- 1.12 agregar (ya esta definido como subtarea de aplanar)

-- 1.13 reversa
reversa :: [a] -> [a]
reversa [] = []
reversa (x:xs) = agregarAlFinal (reversa xs) x

-- 1.14 zipMaximos
zipMaximos :: [Int] -> [Int] -> [Int]
zipMaximos [] ys = ys
zipMaximos xs [] = xs
zipMaximos (x: xs) (y: ys) = max x y :zipMaximos xs ys

-- 1.15 elMinimo
elMinimo :: Ord a => [a] -> a
  -- Precondición: la lista dada no es vacia
elMinimo [x] = x
elMinimo (x:xs) = min x (elMinimo xs)

-- 2 - Recursión sobre números

-- 2.1 - factorial
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n-1)

-- 2.2 - cuentaRegresiva
cuentaRegresiva :: Int -> [Int]
cuentaRegresiva 0 = []
cuentaRegresiva n = n :cuentaRegresiva (n-1)

-- 2.3 repetir
repetir :: Int -> a -> [a]
repetir 0 e = []
repetir n e = e:repetir (n-1) e

-- 2.4 losPrimeros
losPrimeros :: Int -> [a] -> [a]
losPrimeros 0 _ = [] 
losPrimeros n [] = []
losPrimeros n (x:xs) = x: losPrimeros (n-1) xs

-- 2.5 sinLosPrimeros
sinLosPrimeros :: Int -> [a] -> [a]
sinLosPrimeros 0 xs = xs
sinLosPrimeros n [] = []
sinLosPrimeros n (x:xs) = sinLosPrimeros (n-1) xs

-- 3 - Registros

-- 3.1 - Personas

data Persona = P String Int deriving Show

-- 3.1.a mayoresA

edad :: Persona -> Int
edad (P _ e) = e

mayoresA :: Int -> [Persona] -> [Persona]
mayoresA n [] = []
mayoresA n (p:ps) = if edad p > n
                      then p: mayoresA n ps
                      else mayoresA n ps

-- 3.1.b promedioEdad

sumarTodos :: [Int] -> Int
sumarTodos [] = 0 
sumarTodos (n:ns) = n + sumarTodos ns

edades :: [Persona] -> [Int]
edades [] = []
edades (p:ps) = edad p: edades ps

promedioEdad :: [Persona] -> Int
  -- Precondición: La lista dada no es vacia
promedioEdad ps = div (sumarTodos (edades ps)) (length ps)

-- 3.1.c elMasViejo

elMasViejoEntre :: Persona -> Persona -> Persona
elMasViejoEntre p1 p2 = if edad p1 > edad p2
                          then p1
                          else p2

elMasViejo :: [Persona] -> Persona
  -- Precondición: La lista dada no es vacia
elMasViejo [p] = p
elMasViejo (p:ps) = elMasViejoEntre p (elMasViejo ps)

-- 3.2 - Pokemones

data TipoDePokemon = Agua | Fuego | Planta deriving Show
data Pokemon = ConsPokemon TipoDePokemon Int deriving Show
data Entrenador = ConsEntrenador String [Pokemon] deriving Show

-- 3.2.a cantPokemon
cantPokemon :: Entrenador -> Int
cantPokemon (ConsEntrenador _ ps) = length ps

-- 3.2.b cantPokemonDe
tipo :: Pokemon -> TipoDePokemon
tipo (ConsPokemon t _) = t

unoSiPokemonEsDeTipoCeroSino :: TipoDePokemon -> Pokemon -> Int
unoSiPokemonEsDeTipoCeroSino t p =
  if esDeTipo t p
    then 1
    else 0

esDeTipo :: TipoDePokemon -> Pokemon -> Bool
esDeTipo t (ConsPokemon t2 _) = esMismoTipo t t2

esMismoTipo :: TipoDePokemon -> TipoDePokemon -> Bool
esMismoTipo Agua Agua = True
esMismoTipo Fuego Fuego = True
esMismoTipo Planta Planta = True
esMismoTipo _ _ = False

pokemonesDeTipo :: TipoDePokemon -> [Pokemon] -> [Pokemon]
pokemonesDeTipo t [] = []
pokemonesDeTipo t (p:ps) = if esDeTipo t p
                          then p: pokemonesDeTipo t ps
                          else pokemonesDeTipo t ps

cantPokemonDe :: TipoDePokemon -> Entrenador -> Int
cantPokemonDe t (ConsEntrenador _ ps) = length (pokemonesDeTipo t ps)

-- 3.2.c cuantosDeTipo_De_LeGananATodosLosDe_
superaA :: Pokemon -> Pokemon -> Bool
superaA p1 p2 = tipoSuperaA (tipo p1) (tipo p2)

tipoSuperaA :: TipoDePokemon -> TipoDePokemon -> Bool
tipoSuperaA Agua Fuego = True
tipoSuperaA Fuego Planta = True
tipoSuperaA Planta Agua = True
tipoSuperaA _ _ = False

leGanaATodosP :: Pokemon -> [Pokemon] -> Bool
leGanaATodosP p [] = True
leGanaATodosP p (x:xs) =
  superaA p x && leGanaATodosP p xs

los_QueLesGananATodosLos_ :: [Pokemon] -> [Pokemon] -> [Pokemon]
los_QueLesGananATodosLos_ [] ys = []
los_QueLesGananATodosLos_ (x:xs) ys =
  if leGanaATodosP x ys
    then x: los_QueLesGananATodosLos_ xs ys
    else los_QueLesGananATodosLos_ xs ys

-- losDeTipo_De_QueLeGananATodosLosDe_ :: TipoDePokemon -> Entrenador -> Entrenador -> [Pokemon]
-- losDeTipo_De_QueLeGananATodosLosDe_ t (ConsEntrenador _ ps1) (ConsEntrenador _ ps2) =
--   los_QueLesGananATodosLos_ (pokemonesDeTipo t (ps1)) ps2

cuantosDeTipo_De_LeGananATodosLosDe_ :: TipoDePokemon -> Entrenador -> Entrenador -> Int
cuantosDeTipo_De_LeGananATodosLosDe_ t (ConsEntrenador _ ps1) (ConsEntrenador _ ps2) =
  length (los_QueLesGananATodosLos_ (pokemonesDeTipo t (ps1)) ps2)

-- 3.2.d esMaestroPokemon
tieneAlMenosUnPokemonDe :: TipoDePokemon -> Entrenador -> Bool
tieneAlMenosUnPokemonDe t e = cantPokemonDe t e > 0

esMaestroPokemon :: Entrenador -> Bool
esMaestroPokemon e = tieneAlMenosUnPokemonDe Agua e &&
                     tieneAlMenosUnPokemonDe Fuego e &&
                     tieneAlMenosUnPokemonDe Planta e

-- Constantes para probar las funciones
pokemones :: [Pokemon]
pokemones = [ConsPokemon Agua 10, ConsPokemon Agua 20, ConsPokemon Planta 30]

pokemones2 :: [Pokemon]
pokemones2 = [ConsPokemon Fuego 10, ConsPokemon Fuego 20, ConsPokemon Fuego 30, ConsPokemon Fuego 30]

entrenador :: Entrenador
entrenador = ConsEntrenador "Ash" pokemones

entrenador2 :: Entrenador
entrenador2 = ConsEntrenador "Misty" pokemones2

-- 3.3 - Empresas

-- 3.3.a proyectos
data Seniority = Junior | SemiSenior | Senior deriving Show
data Proyecto = ConsProyecto String deriving Show
data Rol = Developer Seniority Proyecto | Management Seniority Proyecto deriving Show
data Empresa = ConsEmpresa [Rol] deriving Show

roles :: Empresa -> [Rol]
roles (ConsEmpresa rs) = rs

proyectoDeRol :: Rol -> Proyecto
proyectoDeRol (Developer _ p) = p
proyectoDeRol (Management _ p) = p

proyectosDeRoles :: [Rol] -> [Proyecto]
proyectosDeRoles [] = []
proyectosDeRoles (r:rs) = proyectoDeRol r: proyectosDeRoles rs

nombreP :: Proyecto -> String
nombreP (ConsProyecto n) = n

sonProyectosIguales :: Proyecto -> Proyecto -> Bool
sonProyectosIguales p1 p2 = nombreP p1 == nombreP p2

proyectoApareceEn :: Proyecto -> [Proyecto] -> Bool
proyectoApareceEn p [] = False
proyectoApareceEn p (x: xs) = sonProyectosIguales p x || proyectoApareceEn p xs

proyectosSinRepetidos :: [Proyecto] -> [Proyecto]
proyectosSinRepetidos [] = []
proyectosSinRepetidos (p:ps) = if proyectoApareceEn p (proyectosSinRepetidos ps)
                                then proyectosSinRepetidos ps
                                else p: proyectosSinRepetidos ps

-- Constantes para probar las funciones
proyectos :: Empresa -> [Proyecto]
proyectos e = proyectosSinRepetidos (proyectosDeRoles (roles e))

-- crea una empresa con 10 roles
empresa :: Empresa
empresa = ConsEmpresa [Developer Junior (ConsProyecto "Proyecto 1"),
                       Developer SemiSenior (ConsProyecto "Proyecto 1"),
                       Developer Senior (ConsProyecto "Proyecto 1"),
                       Developer Junior (ConsProyecto "Proyecto 1"),
                       Developer SemiSenior (ConsProyecto "Proyecto 1"),
                       Developer Senior (ConsProyecto "Proyecto 1"),
                       Developer Junior (ConsProyecto "Proyecto 1"),
                       Developer SemiSenior (ConsProyecto "Proyecto 8"),
                       Developer Senior (ConsProyecto "Proyecto 9"),
                       Developer Junior (ConsProyecto "Proyecto 10")]

-- 3.3.b losDevSenior
esSenior :: Seniority -> Bool
esSenior Senior = True
esSenior _ = False

esDevSenior :: Rol -> Bool
esDevSenior (Developer s _) = esSenior s
esDevSenior _ = False

rolesDevSenior :: [Rol] -> [Rol]
rolesDevSenior [] = []
rolesDevSenior (r: rs) = if esDevSenior r
                        then r: rolesDevSenior rs
                        else rolesDevSenior rs

devsSeniors :: Empresa -> [Rol]
devsSeniors (ConsEmpresa rs) = rolesDevSenior rs

losDevsSeniorQueTrabajanEnAlgun :: Empresa -> [Proyecto] -> [Rol]
losDevsSeniorQueTrabajanEnAlgun e ps = losQueTrabajanEnAlgun (devsSeniors e) ps

losDevSenior :: Empresa -> [Proyecto] -> Int
losDevSenior e ps = length (losDevsSeniorQueTrabajanEnAlgun e ps)

-- 3.3.c cantQueTrabajanEn
cantQueTrabajanEn :: [Proyecto] -> Empresa -> Int
cantQueTrabajanEn ps e = length (losQueTrabajanEnAlgun (roles e) ps)

trabajaEn :: Rol -> Proyecto -> Bool
trabajaEn r p = sonProyectosIguales (proyectoDeRol r) p

trabajaEnAlgun :: [Proyecto] -> Rol -> Bool
trabajaEnAlgun [] r  = False
trabajaEnAlgun (p:ps) r  = trabajaEn r p || trabajaEnAlgun ps r

losQueTrabajanEnAlgun :: [Rol] -> [Proyecto] -> [Rol]
losQueTrabajanEnAlgun [] ps  = []
losQueTrabajanEnAlgun (r: rs) ps =
  if trabajaEnAlgun ps r 
    then r: losQueTrabajanEnAlgun rs ps 
    else losQueTrabajanEnAlgun rs ps 

-- 3.3.d asignadosPorProyecto
asignadosPorProyecto :: Empresa -> [(Proyecto, Int)]
asignadosPorProyecto e =
  zip (proyectos e) (cantAsignadosPorProyecto (proyectos e) (roles e))

cantAsignadosPorProyecto :: [Proyecto] -> [Rol] -> [Int]
cantAsignadosPorProyecto [] rs = []
cantAsignadosPorProyecto (p:ps) rs =
  (cantQueTrabajanEnP p rs): cantAsignadosPorProyecto ps rs 

cantQueTrabajanEnP :: Proyecto -> [Rol] -> Int
cantQueTrabajanEnP p rs = length (losQueTrabajanEnP p rs)

losQueTrabajanEnP :: Proyecto -> [Rol] -> [Rol]
losQueTrabajanEnP p [] = []
losQueTrabajanEnP p (r:rs) =
  if trabajaEn r p
    then r: losQueTrabajanEnP p rs
    else losQueTrabajanEnP p rs