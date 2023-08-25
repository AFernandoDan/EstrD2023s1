#include <iostream>
using namespace std;

// proposito: imprime los caracteres entre c1 y c2 (incluyendo c1 y c2) en ASCII
// Precondición: c1 < c2
void printFromTo(char c1, char c2) {
  for (int i = 0; c1 + i <= c2; i++) {
    cout << c1 + i << ", ";
  }
  cout << endl;
}

int main() {
  printFromTo('a', 'd');
}