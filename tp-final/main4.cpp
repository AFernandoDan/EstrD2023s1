#include <iostream>
using namespace std;
#include <iomanip>
#include "TiposBasicos.h"
#include "TableroInfinito.h"

int main(){
  TableroInfinito t = TInfInicial();
  MoverNTInf(t, OESTE, 1);
  PonerNTInf(t, AZUL,  1);
  PrintRepTInf(t);

  LiberarTInf(t);
}

/* La salida de este programa debe ser la siguiente:

Celda actual: (-1, 0)
BiBST:
  (-1,0): Azul: 1, Negro: 0, Rojo: 0, Verde: 0
*/
     