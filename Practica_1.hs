-- Practica 1

-- Ejercicio 2 - Números Enteros

-- Ejercicio 2.1 - Definir funciones

-- Ejercicio 2.1.a) sucesor
sucesor :: Int -> Int
sucesor x = x + 1

-- Ejercicio 2.1.b) sumar
sumar :: Int -> Int -> Int
sumar a b = a + b

-- Ejercicio 2.1.c) division y resto
divisionYResto :: Int -> Int -> (Int, Int)
divisionYResto a b = (div a b, mod a b)

-- Ejercicio 2.1.d) maximo del par
maxDelPar :: (Int, Int) -> Int
maxDelPar (x, y) = if x > y
                  then x
                  else y

  -- Ejercicio 2.2 - De 4 ejemplos de expresiones diferentes que denoten el número 10,
  -- utilizando en cada expresión a todas las funciones del punto anterior.

  -- Ejemplo 1: sucesor (maxDelPar((snd (divisionYResto (sumar 2 97) 10)), 1))
  -- Ejemplo 2: sumar 2 (sucesor (maxDelPar (divisionYResto 7 1)))
  -- Ejemplo 3: maxDelPar (divisionYResto (sumar 3 7) (sucesor 0))
  -- Ejemplo 4: fst (divisionYResto (sumar 33 (sucesor 70)) (maxDelPar (5+2+3, 9)))

-- 3 - Tipos enumerativos

-- Ejercicio 3.1
data Dir = Norte | Sur | Este | Oeste deriving(Show)

opuesto :: Dir -> Dir
opuesto Norte = Sur
opuesto Sur = Norte
opuesto Este = Oeste
opuesto Oeste = Este

iguales :: Dir -> Dir -> Bool -- en duda
iguales Norte Norte = True
iguales Sur Sur = True
iguales Este Este = True
iguales Oeste Oeste = True
iguales _ _ = False

siguiente :: Dir -> Dir -- en duda
  -- Precondición: La dirección no es Oeste
siguiente Norte = Este
siguiente Este = Sur
siguiente Sur = Oeste
siguiente Oeste = error "No existe una dirección siguiente de Oeste"

-- Ejercicio 3.2
data DiaDeSemana = Lunes | Martes | Miercoles | Jueves | Viernes | Sabado | Domingo

primerDiaDeLaSemana :: DiaDeSemana
primerDiaDeLaSemana = Lunes

ultimoDiaDeLaSemana :: DiaDeSemana
ultimoDiaDeLaSemana = Domingo

primeroYUltimoDia :: (DiaDeSemana, DiaDeSemana)
primeroYUltimoDia = (primerDiaDeLaSemana, ultimoDiaDeLaSemana)

empiezaConM :: DiaDeSemana -> Bool
empiezaConM Martes = True
empiezaConM Miercoles = True
empiezaConM _ = False

vieneDespues :: DiaDeSemana -> DiaDeSemana -> Bool -- en duda
vieneDespues d1 d2 = posiciónEnLaSemana d1 > posiciónEnLaSemana d2

posiciónEnLaSemana :: DiaDeSemana -> Int
posiciónEnLaSemana Lunes = 1
posiciónEnLaSemana Martes = 2
posiciónEnLaSemana Miercoles = 3
posiciónEnLaSemana Jueves = 4
posiciónEnLaSemana Viernes = 5
posiciónEnLaSemana Sabado = 6
posiciónEnLaSemana Domingo = 7

estaEnElMedio :: DiaDeSemana -> Bool -- en duda
estaEnElMedio Lunes = False
estaEnElMedio Domingo = False
estaEnElMedio _ = True

-- Ejercicio 3.3

negar :: Bool -> Bool
negar True = False
negar False = True

implica :: Bool -> Bool -> Bool
implica True False = False
implica _ _ = True

yTambien :: Bool -> Bool -> Bool
yTambien True a = a
yTambien _ _ = False

oBien :: Bool -> Bool -> Bool
oBien True _ = True
oBien _ True = True
oBien _ _ = False

-- Ejercicio 4.1 - Registros

data Persona = P String Int

nombre :: Persona -> String
nombre (P n _) = n

edad :: Persona -> Int
edad (P _ e) = e

crecer :: Persona -> Persona
crecer (P n e) = P n (e+1)

cambioDeNombre :: String -> Persona -> Persona
cambioDeNombre nuevoNombre (P n e) = P nuevoNombre e

esMayorQueLaOtra :: Persona -> Persona -> Bool
esMayorQueLaOtra p1 p2 = edad p1 > (edad p2)

laQueEsMayor :: Persona -> Persona -> Persona
laQueEsMayor p1 p2 = if esMayorQueLaOtra p1 p2
                    then p1
                    else p2

-- Ejercicio 4.2

data TipoDePokemon = Agua | Fuego | Planta deriving (Show)

data Pokemon = Poke TipoDePokemon Int deriving (Show)

data Entrenador = E String Pokemon Pokemon

tipo :: Pokemon -> TipoDePokemon
tipo (Poke t _) = t

superaA :: Pokemon -> Pokemon -> Bool
superaA p1 p2 = tipoSuperaA (tipo p1) (tipo p2)

tipoSuperaA :: TipoDePokemon -> TipoDePokemon -> Bool
tipoSuperaA Agua Fuego = True
tipoSuperaA Fuego Planta = True
tipoSuperaA Planta Agua = True
tipoSuperaA _ _ = False

cantidadDePokemonDe :: TipoDePokemon -> Entrenador -> Int
cantidadDePokemonDe t (E _ p1 p2) =
  unoSiPokemonEsDeTipoCeroSino t p1 + unoSiPokemonEsDeTipoCeroSino t p2

unoSiPokemonEsDeTipoCeroSino :: TipoDePokemon -> Pokemon -> Int
unoSiPokemonEsDeTipoCeroSino t p = if esDeTipo t p
                            then 1
                            else 0

esDeTipo :: TipoDePokemon -> Pokemon -> Bool
esDeTipo t p = esMismoTipo t (tipo p)

esMismoTipo :: TipoDePokemon -> TipoDePokemon -> Bool
esMismoTipo Agua Agua = True
esMismoTipo Fuego Fuego = True
esMismoTipo Planta Planta = True
esMismoTipo _ _ = False

pokemonesDe :: Entrenador -> [Pokemon]
pokemonesDe (E _ p1 p2) = [p1,p2]

juntarPokemon :: (Entrenador, Entrenador) -> [Pokemon]
juntarPokemon (e1,e2) = pokemonesDe e1 ++ pokemonesDe e2

-- 5 - Funciones polimorficas

-- Ejercicio 5.1

loMismo :: a -> a
loMismo a = a

siempreSiete :: a -> Int
siempreSiete _ = 7

swap :: (a, b) -> (b, a)
swap (a,b) = (b, a)

-- En este caso hay dos variables de tipos diferentes porque
-- no necesariamente la tupla tendra ambos elementos del mismo tipo

-- Ejercicio 5.2: Las funciones son polimorficas porque no importan los datos especificos

-- 6 - Pattern matching sobre listas

-- Ejercicio 6.1

estaVacia :: [a] -> Bool
estaVacia [] = True
estaVacia _ = False

elPrimero :: [a] -> a
-- Precondición: estaVacia [a] = Falso
elPrimero (x:_) = x

sinElPrimero :: [a] -> [a]
-- Precondición: estaVacia [a] = Falso
sinElPrimero (_:xs) = xs

splitHead :: [a] -> (a, [a])
-- Precondición: estaVacia [a] = Falso
splitHead (x:xs) = (x, xs)