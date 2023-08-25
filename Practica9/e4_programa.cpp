#include <iostream>
using namespace std;

// Ejercicio 4
// Dar dos implementaciones para las siguientes funciones, una iterativa y otra recursiva, y utilizando
// la menor cantidad posible de variables. Recordar definir subtareas en caso de que sea estrictamente
// necesario.

// VERSION ITERATIVA
// Propósito: imprime n veces un string s.
void printNI(int n, string s) {
  while (n > 0) {
    n--;
    cout << s;
  }
}

// VERSION RECURSIVA
// Propósito: imprime n veces un string s.
void printNR(int n, string s) {
  if (n == 1)
    cout << s;
  else {
    cout << s;
    printNR(n - 1, s);
  }
}

// VERSION ITERATIVA
// Propósito: imprime los números desde n hasta 0, separados por saltos de línea.
void cuentaRegresivaI(int n) {
  while (n > 0) {
    cout << n << endl;
    n--;
  }
  cout << 0 << endl;
}

// VERSION RECURSIVA
// Propósito: imprime los números desde n hasta 0, separados por saltos de línea.
void cuentaRegresivaR(int n) {
  if (n == 0)
    cout << 0 << endl;
  else {
    cout << n << endl;
    cuentaRegresivaR(n - 1);
  }
}

// VERSION ITERATIVA
// Propósito: imprime los números de 0 hasta n, separados por saltos de línea.
void desdeCeroHastaNI(int n) {
  for (int k = 0; k <= n; k++) {
    cout << k << endl;
  }
}

// VERSION RECURSIVA
// Propósito: imprime los números de 0 hasta n, separados por saltos de línea.
void desdeCeroHastaNR(int n) {
  if (n == 0)
    cout << 0 << endl;
  else {
    desdeCeroHastaNR(n - 1);
    cout << n << endl;
  }
}

// ¿Son totales o parciales?
// VERSION ITERATIVA
// Propósito: realiza la multiplicación entre dos números (sin utilizar la operación * de C++).
// precond: los numeros son naturales
int multI(int n, int m) {
  int r = 0;
  for (;m > 0; m--) {
    r += n;
  }
  return r;
}

// VERSION RECURSIVA
// Propósito: realiza la multiplicación entre dos números (sin utilizar la operación * de C++).
int multR(int n, int m) {
  if (m == 0)
    return 0;
  else
    return n + multR(n, m - 1);
}

// VERSION ITERATIVA
// Propósito: imprime los primeros n char del string s, separados por un salto de línea.
// Precondición: el string tiene al menos n char.
void primerosNI(int n, string s) {
  for (int i = 0; i < n; i++) {
    cout << s[i] << endl;
  }
}

// ¿ESTA BIEN?
// VERSION RECURSIVA
// Propósito: imprime los primeros n char del string s, separados por un salto de línea.
// Precondición: el string tiene al menos n char.
void primerosNR(int n, string s) {
  if (n > 1) primerosNR(n - 1, s);
  cout << s[n - 1] << endl;
}

// VERSION ITERATIVA
// Propósito: indica si un char c aparece en el string s.
bool perteneceI(char c, string s) {
  int i = s.length()-1;
  while (i > 0 && c != s[i]) {
    i--;
  }
  return c == s[i];
}

bool perteneceRecursiva(char c, string s, int i) {
  return
    (i == 0 && s[i] == c) ||
    (c == s[i] || perteneceRecursiva(c, s, i-1));
}

// VERSION RECURSIVA
// Propósito: indica si un char c aparece en el string s.
bool perteneceR(char c, string s) {
  return perteneceRecursiva(c, s, s.length());
}

// Proposito: devuelve 1 si el booleano dado es true, sino 0.
int unoSi(bool b) {
  if (b) return 1;
  else return 0;
}

// VERSION ITERATIVA
// Propósito: devuelve la cantidad de apariciones de un char c en el string s
int aparicionesI(char c, string s) {
  int a = 0;
  for (int i = 0; i < s.length(); i++) {
    a += unoSi(s[i] == c);
  }
  return a;
}

int aparicionesRecursivo(char c, string s, int i) {
  if (i==0) return unoSi(s[i] == c);
  else return unoSi(s[i] == c) + aparicionesRecursivo(c, s, i-1);
}

// VERSION RECURSIVA
// Propósito: devuelve la cantidad de apariciones de un char c en el string s
int aparicionesR(char c, string s) {
  return aparicionesRecursivo(c, s, s.length());
}

int main() {
  cout << "ITERATIVO: printNI(3, \"TRES\"):" << endl;
  printNI(3, "TRES");
  cout << "RECURSIVO: printNR(4, \"CUATRO\"):" << endl;
  printNR(4, "CUATRO");
  cout << "ITERATIVO: cuentaRegresivaI(3):" << endl;
  cuentaRegresivaI(3);
  cout << "RECURSIVO: cuentaRegresivaR(3):" << endl;
  cuentaRegresivaR(3);
  cout << "ITERATIVO: desdeCeroHastaNI(3):" << endl;
  desdeCeroHastaNI(3);
  cout << "RECURSIVO: desdeCeroHastaNR(3):" << endl;
  desdeCeroHastaNR(3);
  cout << "ITERATIVO: multI(5,5):" << endl;
  cout << multI(5, 5) << endl;
  cout << "RECURSIVO: multR(5,5):" << endl;
  cout << multR(5, 5) << endl;
  cout << "ITERATIVO: multI(0,5):" << endl;
  cout << multI(0, 5) << endl;
  cout << "RECURSIVO: multR(0,5):" << endl;
  cout << multR(0, 5) << endl;
  cout << "ITERATIVO: multI(5,0):" << endl;
  cout << multI(5, 0) << endl;
  cout << "RECURSIVO: multR(5,0):" << endl;
  cout << multR(5, 0) << endl;
  cout << "ITERATIVO: primerosNI(3, \"TRES\"):" << endl;
  primerosNI(3, "TRES");
  cout << "RECURSIVO: primerosNR(4, \"CUATRO\"):" << endl;
  primerosNR(4, "CUATRO");
  cout << "RECURSIVO: primerosNR(0, \"CERO\"):" << endl;
  primerosNR(0, "CERO");
  cout << "ITERATIVO: perteneceI('C', \"ABCD\"):" << endl;
  cout << perteneceI('C', "ABCD") << endl;
  cout << "ITERATIVO: perteneceI('H', \"ABCD\"):" << endl;
  cout << perteneceI('H', "ABCD") << endl;
  cout << "ITERATIVO: perteneceI('A', \"\"):" << endl;
  cout << perteneceI('A', "") << endl;
  cout << "RECURSIVO: perteneceR('Y', \"WXYZ\"):" << endl;
  cout << perteneceR('Y', "WXYZ") << endl;
  cout << "RECURSIVO: perteneceR('K', \"WXYZ\"):" << endl;
  cout << perteneceR('K', "ABCD") << endl;
  cout << "RECURSIVO: perteneceR('Z', \"\"):" << endl;
  cout << perteneceR('Z', "") << endl;
  cout << "ITERATIVO: aparicionesI('A', \"AAABBBCCC\"):" << endl;
  cout << aparicionesI('A', "AAABBBCCC") << endl;
  cout << "ITERATIVO: aparicionesI('D', \"AAABBBCCC\"):" << endl;
  cout << aparicionesI('D', "AAABBBCCC") << endl;
  cout << "ITERATIVO: aparicionesI('D', \"\"):" << endl;
  cout << aparicionesI('D', "") << endl;
  cout << "RECURSIVO: aparicionesR('A', \"AAABBBCCC\"):" << endl;
  cout << aparicionesR('A', "AAABBBCCC") << endl;
  cout << "RECURSIVO: aparicionesR('D', \"AAABBBCCC\"):" << endl;
  cout << aparicionesR('D', "AAABBBCCC") << endl;
  cout << "RECURSIVO: aparicionesR('D', \"\"):" << endl;
  cout << aparicionesR('D', "") << endl;
}
