import Empleado
import Empresa
import SetV1
import MapV1

unEmpleado :: Empleado
unEmpleado = consEmpleado 112233

-- define la funcion show para Empleado
instance Show Empleado where
  show e = "Empleado " ++ show (cuil e) ++ " " ++ show (setToList (sectores e))

-- define la funcion show para Empresa
instance Show Empresa where
  show e = "Empresa " ++ show (verSectores (todosLosSectores e) e) ++ " " ++ show (verCE (todosLosCUIL e) e)

verSectores :: [SectorId] -> Empresa -> [(SectorId, [Empleado])]
verSectores [] _ = []
verSectores (sid:sids) e = (sid, empleadosDelSector sid e) : verSectores sids e

verCE :: [CUIL] -> Empresa -> [(CUIL, Empleado)]
verCE [] _ = []
verCE (c:cs) e = (c, buscarPorCUIL c e) : verCE cs e

-- Propósito: construye una empresa con la información de
-- empleados dada. Los sectores no tienen empleados.
-- Costo: O(S * [costo agregarSector S] + [costo comenzarConCs C])
-- Costo: O(S * [costo agregarSector S] + [C * [Log C)])
-- Costo: O(S * [Log S] + [C * [Log C)])
-- Costo: O(S * Log S + C * Log C)
comenzarCon :: [SectorId] -> [CUIL] -> Empresa
comenzarCon [] cs = comenzarConCs cs
comenzarCon (s:ss) cs = agregarSector s (comenzarCon ss cs)

-- Propósito: dada una empresa elimina a la mitad de sus empleados (sin importar a quiénes).
-- Costo: O([costo todosLosCUIL (C)] + [costo mitadDeLista (C) ] + [costo recorteDePersonal' (C,S)])
-- Costo: O([C] + [C] + [costo recorteDePersonal' (C,S)])
-- Costo: O([C] + [C] + [C * [Log C + S * [Log C + Log S] + S])
-- Costo: O(C * [Log C + S * [Log C + Log S] + S] + C)
-- Costo: O(C * [S * [Log C + Log S] + S] + C)
-- Siendo C la cantidad de empleados de la empresa
-- Siendo S la cantidad de sectores de la empresa

recorteDePersonal :: Empresa -> Empresa
recorteDePersonal e = recorteDePersonal' (mitadDeLista (todosLosCUIL e)) e

-- Propósito: dado un CUIL de empleado le asigna todos los sectores de la empresa.
-- Costo: O([costo agregarASectores (S,C)] + [costo todosLosSectores (S)])
-- Costo: O([costo agregarASectores (S,C)] + S)
convertirEnComodin :: CUIL -> Empresa -> Empresa
-- Precondición: el cuil pertenece a un empleado de la empresa.
convertirEnComodin c e = agregarASectores (todosLosSectores e) c e

-- Propósito: dado un CUIL de empleado indica si el empleado está en todos los sectores.
-- Costo: O([costo estaEnLosSectores (C,S)] + [costo todosLosSectores S])
-- Costo: O([costo estaEnLosSectores (C,S)] + S)
-- Costo: O(S * [Log S + Log C] + S)
-- Siendo S la cantidad de sectores de la empresa
-- Siendo C la cantidad de empleados de la empresa
esComodin :: CUIL -> Empresa -> Bool
-- Precond: Hay un empleado en la empresa con el cuil dado
esComodin c e = estaEnLosSectores (todosLosSectores e) (sectores (buscarPorCUIL c e))

-- Costo: O(S * [costo estaEnSector])
-- Costo: O(S * [Log S2 + Log C])
-- Siendo S la longitud de la lista ss
-- Siendo S2 la cantidad de sectores de la empresa
-- Siendo C la cantidad de empleados en la empresa
estaEnLosSectores :: [SectorId] -> Set SectorId -> Bool
estaEnLosSectores [] sse = True
estaEnLosSectores (s:ss) sse = belongsS s sse && estaEnLosSectores ss sse 

-- Suponemos que el costo de belongS es Log S
-- Costo: O([costo belongsS (S)] + [costo sectores] + [costo buscarPorCUIL C])
-- Costo: O([costo belongsS (S)] + [costo sectores] + Log C)
-- Costo: O([costo belongsS (S)] + 1 + Log C)
-- Costo: O(Log S + Log C)
-- Siendo S la cantidad de sectores de la empresa
-- Siendo C la cantidad de empleados de la empresa
estaEnSector :: SectorId -> CUIL -> Empresa -> Bool
estaEnSector s c e =
    belongsS s (sectores (buscarPorCUIL c e))

-- Costo: O(S * [costo agregarASector (E,S2)])
-- Costo: O(S * [Log S2 + Log E])
-- Costo: O(S2 * [Log S2 + Log E])
-- Siendo S la longitud de la lista ss
-- Siendo S2 la cantidad de sectores de la empresa
-- Siendo E la cantidad de empleados de la empresa
-- Se puede reemplazar S por S2 ya que en el peor de los casos la lista
-- dada tendra la misma cantidad de elementos que sectores en la empresa.
agregarASectores :: [SectorId] -> CUIL -> Empresa -> Empresa
-- Precondición: el cuil pertenece a un empleado de la empresa,
--                los sectores estan en la empresa.
agregarASectores [] _ e = e
agregarASectores (s:ss) c e = agregarASectores ss c (agregarASector s c e)

-- consEmpresa es O(1)
-- Costo: O(C * [costo agregarEmpleado (S, C)])
-- Costo: O(C * [(S * (Log S + Log C) + Log C)])
-- Costo: O(C * [Log C)])
-- Siendo C la longitud de la lista de CUILs que tendra la empresa
-- Siendo S la cantidad de sectores en los que trabajara cada empleado
-- Como es [] se anula una parte del costo de agregarEmpleado
comenzarConCs :: [CUIL] -> Empresa
comenzarConCs [] = consEmpresa
comenzarConCs (c:cs) = agregarEmpleado [] c (comenzarConCs cs)

-- Costo: O([costo tomarHasta (K)] + [costo length (K)])
-- Costo: O([costo tomarHasta (K)] + K)
-- Costo: O(K + K)
-- Costo: O(K)
mitadDeLista :: [a] -> [a]
mitadDeLista xs = tomarHasta (div (length xs) 2) xs

-- Costo: O(K)
-- Siendo K la longitud de la lista, en el peor
-- de los casos se recorre toda la lista.
tomarHasta :: (Eq t, Num t) => t -> [a] -> [a]
tomarHasta 0 _      = []
tomarHasta _ []     = [] 
tomarHasta n (x:xs) = x : tomarHasta (n-1) xs

-- Costo: O(C * [costo borrarEmpleado (E)])
-- Costo: O(C * [Log C2 + S * [Log C2 + Log S] + S])
-- Siendo C la longitud de la lista cs
-- Siendo C2 la cantidad de empleados de la empresa
-- Siendo S la cantidad de sectores de la empresa
recorteDePersonal' :: [CUIL] -> Empresa -> Empresa
-- Pr
recorteDePersonal' [] e = e
recorteDePersonal' (c:cs) e = borrarEmpleado c (recorteDePersonal' cs e)