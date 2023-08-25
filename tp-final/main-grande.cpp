#include <iostream>
using namespace std;
#include <iomanip>
#include "TiposBasicos.h"
#include "TableroInfinito.h"

void dibujarCruz(TableroInfinito t, Color color) {
  PonerNTInf(t, color, 1);
  MoverNTInf(t, NORTE, 1);
  MoverNTInf(t, ESTE, 1);
  PonerNTInf(t, color, 1);
  MoverNTInf(t, SUR, 2);
  PonerNTInf(t, color, 1);
  MoverNTInf(t, OESTE, 2);
  PonerNTInf(t, color, 1);
  MoverNTInf(t, NORTE, 2);
  PonerNTInf(t, color, 1);
  MoverNTInf(t, SUR, 1);
  MoverNTInf(t, ESTE, 1);
}

int main(){
  TableroInfinito t = TInfInicial();
  PonerNTInf(t, AZUL, 1);
  PonerNTInf(t, ROJO, 1);
  MoverNTInf(t, NORTE, 1);
  MoverNTInf(t, OESTE, 1);
  MoverNTInf(t, OESTE, 1);
  MoverNTInf(t, NORTE, 1);
  PonerNTInf(t, AZUL, 1);
  PonerNTInf(t, ROJO, 1);
  MoverNTInf(t, SUR, 1);
  MoverNTInf(t, ESTE, 1);
  PonerNTInf(t, AZUL, 1);
  PonerNTInf(t, ROJO, 1);
  MoverNTInf(t, SUR, 3);
  MoverNTInf(t, OESTE, 1);
  PonerNTInf(t, AZUL, 1);
  PonerNTInf(t, ROJO, 1);
  MoverNTInf(t, NORTE, 1);
  MoverNTInf(t, ESTE, 1);
  PonerNTInf(t, AZUL, 1);
  PonerNTInf(t, ROJO, 1);
  MoverNTInf(t, SUR, 1);
  MoverNTInf(t, ESTE, 3);
  PonerNTInf(t, AZUL, 1);
  PonerNTInf(t, ROJO, 1);
  MoverNTInf(t, NORTE, 1);
  MoverNTInf(t, OESTE, 1);
  PonerNTInf(t, AZUL, 1);
  PonerNTInf(t, ROJO, 1);
  MoverNTInf(t, NORTE, 3);
  MoverNTInf(t, ESTE, 1);
  PonerNTInf(t, AZUL, 1);
  PonerNTInf(t, ROJO, 1);
  MoverNTInf(t, SUR, 1);
  MoverNTInf(t, OESTE, 1);
  PonerNTInf(t, AZUL, 1);
  PonerNTInf(t, ROJO, 1);
  MoverNTInf(t, SUR, 1);
  MoverNTInf(t, OESTE, 1);

  // va a (-4, -4)
  MoverNTInf(t, SUR, 4);
  MoverNTInf(t, OESTE, 4);
  dibujarCruz(t,VERDE);
  // vuelve a (0, 0)
  MoverNTInf(t, NORTE, 4);
  MoverNTInf(t, ESTE, 4);

  // va a (4, 4)
  MoverNTInf(t, NORTE, 4);
  MoverNTInf(t, ESTE, 4);
  dibujarCruz(t,VERDE);
  // vuelve a (0, 0)
  MoverNTInf(t, SUR, 4);
  MoverNTInf(t, OESTE, 4);

  // va a (4, -4)
  MoverNTInf(t, SUR, 4);
  MoverNTInf(t, ESTE, 4);
  dibujarCruz(t,VERDE);
  // vuelve a (0, 0)
  MoverNTInf(t, NORTE, 4);
  MoverNTInf(t, OESTE, 4);

  // va a (-4, 4)
  MoverNTInf(t, NORTE, 4);
  MoverNTInf(t, OESTE, 4);
  dibujarCruz(t,VERDE);
  // vuelve a (0, 0)
  MoverNTInf(t, SUR, 4);
  MoverNTInf(t, ESTE, 4);
  

  PrintRepTInf(t);

  LiberarTInf(t);
}
