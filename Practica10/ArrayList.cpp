#include "ArrayList.h"
#include <iostream>
using namespace std;

struct ArrayListSt {
  int cantidad; // cantidad de elementos
  int* elementos; // array de elementos
  int capacidad; // tamaño del array
};

// Crea una lista con 0 elementos.
// Nota: empezar el array list con capacidad 16.
ArrayList newArrayList() {
  ArrayListSt* xs = new ArrayListSt;
  xs->cantidad = 0;
  xs->elementos = new int[16];
  xs->capacidad = 16;
  return xs;
}

// Crea una lista con 0 elementos y una capacidad dada por parámetro.
// precond: capacidad > 0
ArrayList newArrayListWith(int capacidad) {
  if (capacidad <= 0) {
    cout << "Error: la capacidad debe ser mayor a 0" << endl;
    exit(1);
  }
  ArrayListSt* xs = new ArrayListSt;
  xs->cantidad = 0;
  xs->elementos = new int[capacidad];
  xs->capacidad = capacidad;
  return xs;
}

// Devuelve la cantidad de elementos existentes.
int lengthAL(ArrayList xs) {
  return xs->cantidad;
}

// Devuelve el iésimo elemento de la lista.
// Precond: i < lengthAL(xs)
int get(int i, ArrayList xs) {
  if (xs->cantidad > i && i >= 0) {
    return (xs->elementos[i]);
  }
  cout << "Error: el indice esta fuera de rango" << endl;
  exit(1);
}

// Reemplaza el iésimo elemento por otro dado.
// Precond: i < lengthAL(xs)
void set(int i, int x, ArrayList xs) {
  if (xs->cantidad <= i || i < 0) {
    cout << "Error: el indice esta fuera de rango" << endl;
    exit(1);
  }
  xs->elementos[i] = x;
}

// Decrementa o aumenta la capacidad del array.
// Nota: en caso de decrementarla, se pierden los elementos del final de la lista.
// Precond: capacidad > 0
void resize(int capacidad, ArrayList xs) {
  if (capacidad <= 0) {
    cout << "Error: la capacidad debe ser mayor a 0" << endl;
    exit(1);
  }
  
  if (xs->capacidad == capacidad)
    return ;
    
  int* temp = new int[xs->capacidad];
  for(int i=0; i<xs->capacidad; i++)
    { temp[i] = xs->elementos[i]; }
  delete xs->elementos;
  xs->elementos = temp;
  xs->capacidad = capacidad;

  if (xs->cantidad > capacidad)
    xs->cantidad = capacidad;
}

// duplica la capacidad del arraylist
void duplicarCapacidad(ArrayList xs) {
  int* temp = new int[xs->capacidad*2];
  for(int i=0; i<xs->capacidad; i++)
    { temp[i] = xs->elementos[i]; }
  delete xs->elementos;
  xs->capacidad = xs->cantidad*2;
  xs->elementos = temp;
}

// Agrega un elemento al final de la lista.
void add(int x, ArrayList xs) {
  if (xs->cantidad == xs->capacidad)
    { duplicarCapacidad(xs); }
  xs->elementos[xs->cantidad++] = x;
}

// Borra el último elemento de la lista.
void remove(ArrayList xs) {
  if (xs->cantidad <= 0) return ;
  xs->cantidad--;
}