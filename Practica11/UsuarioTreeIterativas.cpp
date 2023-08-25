#include "Tree.h"
#include "../Practica10/ArrayList.h"
#include "./QueueT.h"
#include <iostream>
using namespace std;

// esta funcion no viene al caso solo sirve para mostrar un ArrayList
void showAL(ArrayList xs) {
  cout << "[";
  for (int i = 0; i < lengthAL(xs); i++) {
    cout << get(i,xs);
    if (i < lengthAL(xs)-1) cout << ", ";
  }
  cout << "]" << endl;
}

// funciones sobre arboles

int sumarTree(Tree t) {
  int totalVisto = 0; Tree actual;
  QueueT faltanProcesar = emptyQT(); // Nunca habra emptyT en la cola
  if (!isEmptyT(t)) EnqueueT(t, faltanProcesar);
  while(!isEmptyQT(faltanProcesar)) {
    actual = firstQT(faltanProcesar); // actual NO es emptyT
    DequeueT(faltanProcesar);
    totalVisto += rootT(actual);
    if (!isEmptyT(left(actual))) { EnqueueT(left(actual) , faltanProcesar); }
    if (!isEmptyT(right(actual))) { EnqueueT(right(actual), faltanProcesar); }
  }
  DestroyQT(faltanProcesar);
  return(totalVisto);
}

// Dado un árbol binario devuelve su cantidad de elementos,
// es decir, el tamaño del árbol (size en inglés).
int sizeT(Tree t) {
  int size = 0; Tree actual;
  QueueT faltanProcesar = emptyQT(); // Nunca habra emptyT en la cola
  if (!isEmptyT(t)) EnqueueT(t, faltanProcesar);
  while(!isEmptyQT(faltanProcesar)) {
    actual = firstQT(faltanProcesar); // actual NO es emptyT
    DequeueT(faltanProcesar);
    size += 1;
    if (!isEmptyT(left(actual))) { EnqueueT(left(actual) , faltanProcesar); }
    if (!isEmptyT(right(actual))) { EnqueueT(right(actual), faltanProcesar); }
  }
  DestroyQT(faltanProcesar);
  return(size);
}

// Dados un elemento y un árbol binario devuelve True si
// existe un elemento igual a ese en el árbol.
bool perteneceT(int e, Tree t) {
  Tree actual = t;
  QueueT faltanProcesar = emptyQT(); // Nunca habra emptyT en la cola
  if (!isEmptyT(t)) EnqueueT(t, faltanProcesar);
  while(!isEmptyQT(faltanProcesar) && rootT(actual) != e) {
    actual = firstQT(faltanProcesar); // actual NO es emptyT
    DequeueT(faltanProcesar);
    if (!isEmptyT(left(actual))) { EnqueueT(left(actual) , faltanProcesar); }
    if (!isEmptyT(right(actual))) { EnqueueT(right(actual), faltanProcesar); }
  }
  DestroyQT(faltanProcesar);
  return(!isEmptyT(actual) && rootT(actual) == e);
}

int unoSi(bool b) {
  if (b) return 1;
  else return 0;
}

// Dados un elemento e y un árbol binario devuelve la
// cantidad de elementos del árbol que son iguales a e.
int aparicionesT(int e, Tree t) {
  int apariciones = 0; Tree actual;
  QueueT faltanProcesar = emptyQT(); // Nunca habra emptyT en la cola
  if (!isEmptyT(t)) EnqueueT(t, faltanProcesar);
  while(!isEmptyQT(faltanProcesar)) {
    actual = firstQT(faltanProcesar); // actual NO es emptyT
    DequeueT(faltanProcesar);
    apariciones += unoSi(rootT(actual) == e);
    if (!isEmptyT(left(actual))) { EnqueueT(left(actual) , faltanProcesar); }
    if (!isEmptyT(right(actual))) { EnqueueT(right(actual), faltanProcesar); }
  }
  DestroyQT(faltanProcesar);
  return(apariciones);
}

void toListR(Tree t, ArrayList al) {
  if (!isEmptyT(t)) {
    add(rootT(t), al);
    toListR(left(t), al);
    toListR(right(t), al);
  }
}

// Dado un árbol devuelve una lista con todos sus elementos.
ArrayList toList(Tree t) {
  ArrayList al = newArrayList(); Tree actual;
  QueueT faltanProcesar = emptyQT(); // Nunca habra emptyT en la cola
  if (!isEmptyT(t)) EnqueueT(t, faltanProcesar);
  while(!isEmptyQT(faltanProcesar)) {
    actual = firstQT(faltanProcesar); // actual NO es emptyT
    DequeueT(faltanProcesar);
    add(rootT(actual), al);
    if (!isEmptyT(left(actual))) { EnqueueT(left(actual) , faltanProcesar); }
    if (!isEmptyT(right(actual))) { EnqueueT(right(actual), faltanProcesar); }
  }
  DestroyQT(faltanProcesar);
  return(al);
}

int main() {
  // albol del 1 al 7
  Tree t = 
    nodeT(1,
      nodeT(2,
        nodeT(4,
          emptyT(), emptyT()),
        nodeT(5,
          emptyT(), emptyT())),
      nodeT(3,
        nodeT(6,
          emptyT(), emptyT()),
        nodeT(7,
          emptyT(), emptyT())));

  // arbol con 3 unos y 4 sietes.
  Tree t2 = 
    nodeT(1,
      nodeT(1,
        nodeT(7,
          emptyT(), emptyT()),
        nodeT(7,
          emptyT(), emptyT())),
      nodeT(1,
        nodeT(7,
          emptyT(), emptyT()),
        nodeT(7,
          emptyT(), emptyT())));

  // arbol no lleno
  Tree t3 = 
    nodeT(1,
      nodeT(2,
        nodeT(4,
          emptyT(), emptyT()),
        nodeT(5,
          emptyT(), emptyT())),
      nodeT(3,
        nodeT(6,
          emptyT(), emptyT()),
        emptyT()));

  // arbol 1
  //      2 3
  //     4
  Tree t4 = 
    nodeT(1,
      nodeT(2,
        nodeT(4,
          emptyT(), emptyT()),
        emptyT()),
      nodeT(3,
        emptyT(), emptyT()));

  cout << "Resultado de sumar t:" << sumarTree(t) << endl;
  cout << "Tamanio de t:" << sizeT(t) << endl;
  cout << "Pertenece 1 a t:" << perteneceT(1,t) << endl;
  cout << "Pertenece 10 a t:" << perteneceT(10,t) << endl;
  cout << "Apariciones de 4 en t:" << aparicionesT(4,t) << endl;
  cout << "Apariciones de 10 en t:" << aparicionesT(10,t) << endl;

  cout << "Resultado de sumar t2:" << sumarTree(t2) << endl;
  cout << "Tamanio de t2:" << sizeT(t2) << endl;
  cout << "Pertenece 1 a t2:" << perteneceT(1,t2) << endl;
  cout << "Pertenece 10 a t2:" << perteneceT(10,t2) << endl;
  cout << "Apariciones de 1 en t2:" << aparicionesT(1,t2) << endl;
  cout << "Apariciones de 7 en t2:" << aparicionesT(7,t2) << endl;
  cout << "Apariciones de 10 en t2:" << aparicionesT(10,t2) << endl;

  cout << "toList(t): ";
  showAL(toList(t));

  cout << "toList(t2): ";
  showAL(toList(t2));

  cout << "toList(t3): ";
  showAL(toList(t3));

  cout << "toList(emptyT()): ";
  showAL(toList(emptyT()));

  cout << "fin del programa" << endl;
}