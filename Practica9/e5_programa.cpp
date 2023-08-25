#include <iostream>
using namespace std;

// Ejercicio 5
// Dada la estructura de fracciones representada como struct en C++, definir las siguientes funciones
// sobre fracciones. Recordar probar las implementaciones en un procedimiento main.
struct Fraccion {
  int numerador;
  int denominador;
};

// Propósito: construye una fraccion
// Precondición: el denominador no es cero
Fraccion consFraccion(int numerador, int denominador) {
  Fraccion f;
  f.numerador = numerador; f.denominador = denominador;
  return f;
}

// Propósito: devuelve el numerador
int numerador(Fraccion f) {
  return f.numerador;
}

// Propósito: devuelve el denominador
int denominador(Fraccion f) {
  return f.denominador;
}

// Propósito: devuelve el resultado de hacer la división
float division(Fraccion f) {
  return f.numerador / f.denominador;
}

// Propósito: devuelve una fracción que resulta de multiplicar las fracciones
// (sin simplificar)
Fraccion multF(Fraccion f1, Fraccion f2) {
  f1.numerador *= f2.numerador, f1.denominador *= f2.denominador;
  return f1;
}

// Proposito: devuelve el maximo comun divisor entre ambos numeros;
int maxComunDivisor(int n, int m) {
  int mcd = min(n,m);
  while (!(n % mcd == 0 || n % mcd == 0)) {
    mcd--;
  }
  return mcd;
}

// Propósito: devuelve una fracción que resulta
// de simplificar la dada por parámetro
Fraccion simplificada(Fraccion f) {
  int mcd = maxComunDivisor(f.numerador, f.denominador);
  f.numerador /= mcd;
  f.denominador /= mcd;
  return f;
}

// Propósito: devuelve una fracción que resulta de sumar las fracciones
Fraccion sumF(Fraccion f1, Fraccion f2) {
  f1.numerador *= f2.denominador;
  f1.numerador += f2.numerador * f1.denominador;
  f1.denominador *= f2.denominador;
  return f1;
}

void showFraccion(Fraccion f) {
  cout << f.numerador;
  cout << "/";
  cout << f.denominador << endl; 
}

int main() {
  cout << "consFraccion(1,1)" << endl;
  showFraccion(consFraccion(1,1));

  Fraccion f1 = consFraccion(4,2);
  Fraccion f2 = consFraccion(3,2);

  cout << "f1 = 4/2 y f2 = 3/2" << endl;

  cout << "multF(f1, f2)" << endl;
  showFraccion(multF(f1,f2));

  cout << "sumF(f1, f2)" << endl;
  showFraccion(sumF(f1,f2));

  cout << "simplificada(consFraccion(5040, 720))" << endl;
  showFraccion(simplificada(consFraccion(5040, 720)));

  cout << "simplificada(consFraccion(40320, 362880))" << endl;
  showFraccion(simplificada(consFraccion(40320, 362880)));
}