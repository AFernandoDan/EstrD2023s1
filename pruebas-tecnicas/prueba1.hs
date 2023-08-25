-- dado una lista de almenos 2 numeros el resultado
-- mayor del la suma de dos numeros adyacentes

mayorSumaAdyacente :: [Int] -> Int
-- precond: la lista tiene almenos 2 elementos
mayorSumaAdyacente (x: y: []) = x + y
mayorSumaAdyacente (x: y: ys) = 
  let n = mayorSumaAdyacente (y:ys) in
    max (x + y) n

