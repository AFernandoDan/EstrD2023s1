#include <iostream>
#include <algorithm>
#include "BiBST.h"
#include "TiposBasicos.h"
using namespace std;


//==========================================================================
// Invariante de representación
//==========================================================================
/* INV.REP.
  Siendo (kx,ky) la clave de un BiBST y (x,y) la clave de cualquiera de sus hijos 
  * las claves de los hijos hijo[NE] de un BiBST cumplen que
    x > kx && y > ky
  * las claves de los Hijos hijo[SE] de un BiBST cumplen que
    x > kx && y <= ky
  * las claves de los Hijos hijo[NO] de un BiBST cumplen que
    x <= kx && y > ky
  * las claves de los Hijos hijo[SO] de un BiBST cumplen que
    x <= kx && y <= ky
  * Todos los hijos de un BiBST son BiBSTs
*/

//==========================================================================
// Implementación
//==========================================================================
BBNode* findBBNode(BBNode* nodo, int x, int y) { 
  if (nodo == NULL) {
    return NULL;
  }

  if (nodo->kx == x && nodo->ky == y) {
    return nodo;
  }

  if (x > nodo->kx && y > nodo->ky) {
    return findBBNode(nodo->hijo[NE], x, y);
  }

  if (x > nodo->kx && y <= nodo->ky) {
    return findBBNode(nodo->hijo[SE], x, y);
  }
  if (x <= nodo->kx && y > nodo->ky) {
    return findBBNode(nodo->hijo[NO], x, y);
  }

  // caso: x <= nodo->kx && y <= nodo->ky
  return findBBNode(nodo->hijo[SO], x, y);
}

// Proposito: Devuelve un nodo con la clave dada.
BBNode* BBNodeIn(int x, int y) {
  BBNode* nuevoNodo = new BBNode;
  nuevoNodo->kx =x;
  nuevoNodo->ky =y;
  return nuevoNodo;
}

// Proposito: indiaca si el cuadrante es valido
#define VALIDCUADRANTE(cuadrante) (NE <= cuadrante && cuadrante <= SO)

// Proposito: devuelve el nodo del árbol con las claves dadas,
//  si el nodo no existe, lo crea y lo inserta adecuadamente en el árbol
BBNode* insertBBNodeConAnterior(BBNode* nodoAnterior, Cuadrante c, BBNode* nodo, int x, int y) {
  // Precond: el cuadrante debe ser valido
  if (!VALIDCUADRANTE(c)) {
    BOOM("El cuadrante no es valido");
  }

  if (nodo == NULL) {
    BBNode* nuevoNodo = BBNodeIn(x,y);
    if (nodoAnterior != NULL) {
      nodoAnterior->hijo[c] = nuevoNodo;
    }
    return nuevoNodo;
  }

  if (x == nodo->kx && y == nodo->ky) {
    return nodo;
  }

  if (x > nodo->kx && y > nodo->ky) {
    return insertBBNodeConAnterior(nodo, NE, nodo->hijo[NE], x, y);
  }

  if (x > nodo->kx && y <= nodo->ky) {
    return insertBBNodeConAnterior(nodo, SE, nodo->hijo[SE], x, y);
  }

  if (x <= nodo->kx && y > nodo->ky) {
    return insertBBNodeConAnterior(nodo, NO, nodo->hijo[NO], x, y);
  }

  // caso: x <= nodo->kx && y <= nodo->ky
  return insertBBNodeConAnterior(nodo, SO, nodo->hijo[SO], x, y);;
}

BBNode* insertBBNode(BBNode* nodo, int x, int y) {
  return insertBBNodeConAnterior(NULL, NO, nodo, x, y);
}

void LiberarBiBST(BiBST t) { 
  if (t != NULL) {
    LiberarBiBST(t->hijo[NE]);
    LiberarBiBST(t->hijo[SE]);
    LiberarBiBST(t->hijo[NO]);
    LiberarBiBST(t->hijo[SO]);
    delete t;
  }
}

//==========================================================================
// Impresión para verificaciones
//==========================================================================
void PrintBBNode(BBNode* t, int tab) {
  if (t == NULL) { return; }
  INDENT(tab)
  cout << "  (" << t->kx << "," << t->ky << "): ";
  PRINTCOLORN(AZUL , t->bolitas[AZUL ]); 
  cout << ", "; PRINTCOLORN(NEGRO, t->bolitas[NEGRO]); 
  cout << ", "; PRINTCOLORN(ROJO , t->bolitas[ROJO ]); 
  cout << ", "; PRINTCOLORN(VERDE, t->bolitas[VERDE]); 
  cout << endl;
  PrintBBNode(t->hijo[NE], ++tab);
  PrintBBNode(t->hijo[SE], tab);
  PrintBBNode(t->hijo[NO], tab);
  PrintBBNode(t->hijo[SO], tab);
}

void PrintBB(BiBST t) {
  cout << "BiBST:" << endl;
  PrintBBNode(t, 0);
}