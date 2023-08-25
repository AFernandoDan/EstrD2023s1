#include <iostream>
using namespace std;
#include "ArrayList.h"

void showAL(ArrayList xs) {
  cout << "[";
  for (int i = 0; i < lengthAL(xs); i++) {
    cout << get(i,xs);
    if (i < lengthAL(xs)-1) cout << ", ";
  }
  cout << "]" << endl;
}

// Devuelve la suma de todos los elementos
int sumatoria(ArrayList xs) {
  int s = 0;
  for (int i = 0; i < lengthAL(xs); i++) {
    s += get(i,xs);
  }
  return s;
}

// Incrementa en uno todos los elementos.
void sucesores(ArrayList xs) {
  for (int i = 0; i < lengthAL(xs); i++) {
    set(i, get(i,xs)+1, xs);
  }
}

// Indica si el elemento pertenece a la lista.
bool pertenece(int x, ArrayList xs) {
  int i = 0;
  while (i < lengthAL(xs) && get(i,xs) != x)
    i++;
  return i < lengthAL(xs);
}

// Indica la cantidad de elementos iguales a x.
int apariciones(int x, ArrayList xs) {
  int a = 0;
  for (int i = 0; i < lengthAL(xs); i++)
    if (get(i,xs) == x) a++;
  return a;
}

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

// Devuelve el minimo de los dos numeros
int minimoEntre (int n, int m) {
  if (n < m) return n;
  return m;
}

// Devuelve el elemento más chico de la lista.
int minimo(ArrayList xs) {
// precond: la lista tiene almenos un elemento
  int m = get(0, xs);
  for (int i = 0; i < lengthAL(xs); i++) {
    m = minimoEntre(m, get(i, xs));
  }
  return m;
}

int main(int argc, char* argv[]) {
  ArrayList xs = newArrayList();
  ArrayList xs2 = newArrayListWith(20);
  add(10, xs);
  add(20, xs);
  add(30, xs);
  add(40, xs);
  showAL(xs);
  remove(xs);
  showAL(xs);
  resize(10,xs);
  showAL(xs);
  cout << "lengthAL(xs) = ";
  cout << lengthAL(xs) << endl;
  remove(xs);
  cout << "lengthAL(xs) = ";
  cout << lengthAL(xs) << endl;
  cout << get(atoi(argv[1]), xs) << endl;

  ArrayList xs1 = newArrayList();
  add(10,xs1);
  add(20,xs1);
  add(30,xs1);
  cout << "sumatoria(xs1) = ";
  cout << sumatoria(xs1) << endl;

  cout << "Lista xs1 luego de sucesores(xs1): ";
  sucesores(xs1);
  showAL(xs1);
  
  cout << "pertenece(11, xs1): ";
  cout << pertenece(11, xs1) << endl;

  cout << "pertenece(100, xs1): ";
  cout << pertenece(100, xs1) << endl;

  ArrayList xs3 = newArrayList();
  cout << "xs3 = ";
  showAL(xs3);
  cout << "pertenece(100, xs3): ";
  cout << pertenece(100, xs3) << endl;

  ArrayList xs4 = newArrayList();
  add(1,xs4);
  add(1,xs4);
  add(2,xs4);
  add(2,xs4);
  add(2,xs4);
  add(3,xs4);
  cout << "xs4 = ";
  showAL(xs4);

  cout << "apariciones(2, xs4): ";
  cout << apariciones(2, xs4) << endl;

  cout << "xs4 = ";
  showAL(xs4);

  ArrayList xs5 = newArrayList();
  add(7, xs5);
  add(7, xs5);
  add(7, xs5);

  cout << "xs5 = ";
  showAL(xs5);

  cout << "append(xs4, xs5) = ";
  showAL(append(xs4, xs5));

  cout << "lengthAL(append(xs4, xs5)) = ";
  cout << lengthAL(append(xs4, xs5)) << endl;

  ArrayList xs6 = newArrayList();
  add(18, xs6);
  add(330, xs6);
  add(96, xs6);
  add(40, xs6);
  add(12, xs6);
  add(77, xs6);
  add(26, xs6);
  add(15, xs6);
  add(100, xs6);

  cout << "xs6 = ";
  showAL(xs6);

  cout << "minimo(xs6) = ";
  cout << minimo(xs6) << endl;

  ArrayList myAl = newArrayListWith(10);
}