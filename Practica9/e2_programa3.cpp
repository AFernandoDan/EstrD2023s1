#include <iostream>
using namespace std;

// proposito: devuelve la suma de numeros entre n hasta m
// Precondición: n <= m
int ft(int n, int m) {
  if (n == m) {
    return n;
  }
  return n + ft(n + 1, m);
}

// proposito: devuelve la suma de numeros entre n hasta m
// Precondición: n <= m
int ft_mejorado(int n, int m) {
  int i = 0;
  while (n <= m) {
    i += n;
    n++;
  }
  return i;
}

int main() {
  cout << ft_mejorado(1, 3) << endl;
}