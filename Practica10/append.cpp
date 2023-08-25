#include <iostream>
using namespace std;
#include "ArrayList.h"

// Agrega los elementos de la primer lista en la segunda;
void addAll(ArrayList xs, ArrayList ys) {
  for (int i = 0; i < lengthAL(xs); i++) {
    add(get(i,xs),ys);
  }  
}

// Crea una nueva lista a partir de la primera y la segunda (en ese orden).
ArrayList append(ArrayList xs, ArrayList ys) {
  ArrayList zs = newArrayListWith(lengthAL(xs)+lengthAL(ys));
  addAll(xs, zs);
  addAll(ys, zs);
  return zs;
}