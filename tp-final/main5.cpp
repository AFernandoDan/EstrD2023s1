#include <iostream>
using namespace std;
#include <iomanip>
#include "TiposBasicos.h"
#include "TableroInfinito.h"

int main(){
  TableroInfinito t = TInfInicial();
  MoverNTInf(t, OESTE, 1);
  PonerNTInf(t, AZUL, 0);
  PonerNTInf(t, AZUL, 0);
  PonerNTInf(t, AZUL, 0);
  SacarNTInf(t, AZUL, -10);
  PonerNTInf(t, AZUL, 0);
  PonerNTInf(t, AZUL, -10);
  PrintRepTInf(t);
  SacarNTInf(t, AZUL, 0);
  PrintRepTInf(t);


  LiberarTInf(t);
}

/* La salida de este programa debe ser la siguiente:

Celda actual: (-1, 0)
BiBST:
*/
     