#include "Tree.h"
#include "../Practica10/ArrayList.h"
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
  if (isEmptyT(t)) return 0;
  else return rootT(t) + sumarTree(left(t)) + sumarTree(right(t)); 
}
// Dado un árbol binario de enteros devuelve la suma entre sus elementos.
// Costo: O(N)
// Siendo N la cantidad de elementos del arbol dado.

// Dado un árbol binario devuelve su cantidad de elementos,
// es decir, el tamaño del árbol (size en inglés).
int sizeT(Tree t) {
  if (isEmptyT(t)) return 0;
  else return 1 + sizeT(left(t)) + sizeT(right(t));
}
// Costo O(N)
// Siendo N la cantidad e elementos del arbol dado.

// Dados un elemento y un árbol binario devuelve True si
// existe un elemento igual a ese en el árbol.
bool perteneceT(int e, Tree t) {
  // if (isEmptyT(t)) return false;
  // else return rootT(t) == e || perteneceT(e,left(t)) || perteneceT(e,right(t));

  // refactor
  return !isEmptyT(t) && (rootT(t) == e || perteneceT(e,left(t)) || perteneceT(e,right(t)));
}
// Costo O(N)
// Siendo N la cantidad e elementos del arbol dado.

int unoSi(bool b) {
  if (b) return 1;
  else return 0;
}

// Dados un elemento e y un árbol binario devuelve la
// cantidad de elementos del árbol que son iguales a e.
int aparicionesT(int e, Tree t) {
  if (isEmptyT(t)) return 0;
  else return unoSi(rootT(t) == e) + aparicionesT(e, left(t)) + aparicionesT(e, right(t));
}

// Dado un árbol devuelve su altura.
int heightT(Tree t) {
  if (isEmptyT(t)) return 0;
  else return 1 + max(heightT(left(t)), heightT(right(t)));
}
// Costo O(N)
// Siendo N la cantidad e elementos del arbol dado.

void toListR(Tree t, ArrayList al) {
  if (!isEmptyT(t)) {
    add(rootT(t), al);
    toListR(left(t), al);
    toListR(right(t), al);
  }
}

// Dado un árbol devuelve una lista con todos sus elementos.
ArrayList toList(Tree t) {
  ArrayList al = newArrayList();
  toListR(t, al);
  return al;  
}

void leavesR(Tree t, ArrayList al) {
  if (!isEmptyT(t)) {
    if (isEmptyT(left(t)) && isEmptyT(right(t))) add(rootT(t), al);
    else {
      leavesR(left(t), al);
      leavesR(right(t), al);
    }
  }
}

// Dado un árbol devuelve los elementos que se encuentran en sus hojas.
ArrayList leaves(Tree t) {
  ArrayList al = newArrayList();
  leavesR(t, al);
  return al;  
}

// Solucion en haskell
// levelN :: Int -> Tree a -> [a]
// levelN _ EmptyT = []
// levelN 0 (NodeT x _ _) = x:[]
// levelN n (NodeT _ t1 t2) = levelN (n-1) t1 ++ levelN (n-1) t2

void levelNR(int n, Tree t, ArrayList al) {
  if (!isEmptyT(t)) {
    if (n == 0) add(rootT(t), al);
    else {
      levelNR(n-1, left(t), al);
      levelNR(n-1, right(t), al);
    }
  }
}

// Dados un número n y un árbol devuelve una lista con los nodos de nivel n.
ArrayList levelN(int n, Tree t) {
  ArrayList al = newArrayList();
  levelNR(n, t, al);
  return al;  
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

  cout << "Altura del arbol t:" << heightT(t) << endl;
  cout << "Altura del arbol t2:" << heightT(t2) << endl;
  cout << "Altura del arbol t3:" << heightT(t3) << endl;
  cout << "Altura del arbol vacio:" << heightT(emptyT()) << endl;

  cout << "toList(t): ";
  showAL(toList(t));

  cout << "toList(t2): ";
  showAL(toList(t2));

  cout << "toList(t3): ";
  showAL(toList(t3));

  cout << "toList(emptyT()): ";
  showAL(toList(emptyT()));

  cout << "Hojas de t: ";
  showAL(leaves(t));

  cout << "Hojas de t2: ";
  showAL(leaves(t2));

  cout << "Hojas de t3: ";
  showAL(leaves(t3));

  cout << "Hojas de emptyT(): ";
  showAL(leaves(emptyT()));

  cout << "Nivel 0 de t: ";
  showAL(levelN(0, t));

  cout << "Nivel 1 de t: ";
  showAL(levelN(1, t));

  cout << "Nivel 2 de t: ";
  showAL(levelN(2, t));

  cout << "Nivel 0 de t2: ";
  showAL(levelN(0, t2));

  cout << "Nivel 1 de t2: ";
  showAL(levelN(1, t2));

  cout << "Nivel 2 de t2: ";
  showAL(levelN(2, t2));

  cout << "Nivel 0 de t3: ";
  showAL(levelN(0, t3));

  cout << "Nivel 1 de t3: ";
  showAL(levelN(1, t3));

  cout << "Nivel 2 de t3: ";
  showAL(levelN(2, t3));

  cout << "Nivel 0 de emptyT(): ";
  showAL(levelN(0, emptyT()));
  
  cout << "Hojas de t4: ";
  showAL(leaves(t4));

  cout << "fin del programa" << endl;
}