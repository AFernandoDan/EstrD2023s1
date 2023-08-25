#include <iostream>
#include <algorithm>
#include "BiBST.h"
#include "TiposBasicos.h"
using namespace std;


//==========================================================================
// Invariante de representación
//==========================================================================
/* INV.REP.
  Siendo (kx,ky) la clave de un BiBST y (x,y) siendo la clave de cualquiera
    de sus hijos que no son EMPTYBB. 
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

// Proposito: dado un nodo no nulo devuelve el cuadrante donde podria
//  ir el nodo con las claves dadas
Cuadrante cuadranteEn(BBNode* nodo, int x, int y) {
// Precond: el nodo no es nulo
  Cuadrante c;
  if (x > nodo->kx) {
    if (y > nodo->ky) {
      return NE;
    } else {
      return SE;
    }
  } else {
    if (y > nodo->ky) {
      return NO;
    } else {
      return SO;
    }
  }
}

// findBBNode: Iterativo
BBNode* findBBNodeI(BBNode* nodo, int x, int y) { 
  BBNode* current = nodo;

  while(current != NULL && !(x == current->kx && y == current->ky)) {
    current = current->hijo[cuadranteEn(nodo, x, y)];
  }

  return current;
}

// findBBNodeR: Recursivo
BBNode* findBBNode(BBNode* nodo, int x, int y) {
  if (nodo == NULL) {
    return NULL;
  }

  if (nodo->kx == x && nodo->ky == y) {
    return nodo;
  }

  return findBBNode(nodo->hijo[cuadranteEn(nodo, x, y)], x, y);
}

// Proposito: Devuelve un nodo con la clave dada.
BBNode* BBNodeIn(int x, int y) {
  BBNode* nuevoNodo = new BBNode;
  nuevoNodo->kx =x;
  nuevoNodo->ky =y;
  return nuevoNodo;
}

// insertBBNode: Iterativo
BBNode* insertBBNodeI(BBNode* nodo, int x, int y) {
  Cuadrante c;
  BBNode* prev = NULL;
  BBNode* current = nodo;

  while(current != NULL && !(x == current->kx && y == current->ky)) {
    prev = current;
    c = cuadranteEn(current, x, y);
    current = current->hijo[c];
  }
  
  if (current == NULL) {
    BBNode* nuevoNodo = BBNodeIn(x,y);
    if (prev != NULL) {
      prev->hijo[c] = nuevoNodo;
    }
    return nuevoNodo;
  }

  return current;
}

// insertBBNodeR: Recursivo
BBNode* insertBBNode(BBNode* nodo, int x, int y) {

  if (nodo == NULL) {
    return BBNodeIn(x, y);
  }

  if (nodo->kx == x && nodo->ky == y) {
    return nodo;
  }

  Cuadrante c = cuadranteEn(nodo, x, y);
  // Version sugerencia de Ale
  BBNode* nuevoNodo = insertBBNode(nodo->hijo[c], x, y);
  if (nodo->hijo[c] == NULL) {
    nodo->hijo[c] = nuevoNodo;
  }
  return nuevoNodo;

  // Version original
  // if (nodo->hijo[c] == NULL) {
  //   BBNode* nuevoNodo = BBNodeIn(x, y);
  //   nodo->hijo[c] = nuevoNodo;
  //   return nuevoNodo;
  // } else {
  //   return insertBBNode(nodo->hijo[c], x, y);
  // }
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