#include <iostream>
using namespace std;

// proposito: devuelve el factorial del numero dado
// Precondición: n >= 0
int fc(int n) {
  int x = 1;
  while (n > 0) {
    x = x * n;
    n--;
  }
  return x;
}

int main() {
  cout << fc(1) << endl;
  cout << fc(2) << endl;
  cout << fc(3) << endl;
  cout << fc(4) << endl;
}