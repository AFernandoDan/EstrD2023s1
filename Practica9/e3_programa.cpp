#include <iostream>
using namespace std;

struct Par {
  int x;
  int y;
};

// Propósito : construye un par
Par consPar(int x, int y) {
  Par p;
  p.x = x;
  p.y = y;
  return p;
}

// Propósito: devuelve la primera componente
int fst(Par p) {
  return p.x;
}

// Propósito: devuelve la segunda componente
int snd(Par p) {
  return p.y;
}

// Propósito: devuelve la mayor componente
int maxDelPar(Par p) {
  if (p.x > p.y)
    return p.x;
  else
    return p.y;
}

// Propósito: devuelve un par con las componentes intercambiadas
Par swap(Par p) {
  return consPar(p.y, p.x);
}

// Propósito: devuelve un par donde la primer componente
// es la división y la segunda el resto entre ambos números
Par divisionYResto(int n, int m) {
  return consPar(n / m, n % m);
}

void showPar(Par p) {
  cout << "(";
  cout << p.x;
  cout << ",";
  cout << p.y;
  cout << ")" << endl;
}

int main() {
  showPar(consPar(1, 2));
  cout << fst(consPar(1, 2)) << endl;
  cout << snd(consPar(1, 2)) << endl;
  cout << maxDelPar(consPar(1, 2)) << endl;
  cout << maxDelPar(consPar(3, 2)) << endl;
  showPar(swap(consPar(1, 2)));
  showPar(divisionYResto(10, 3));
}