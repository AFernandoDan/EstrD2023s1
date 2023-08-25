#include "Persona.h"

void ShowPersona(Persona p) {
  cout << "Persona[" << p << "]("; 
  cout << "nombre <- \"" << nombre(p) << "\", ";
  cout << "edad <- " << edad(p);
  cout << ")" << endl;
}

int main() {
  Persona p1 = consPersona("Juan", 20);
  ShowPersona(p1); cout << endl;
  crecer(p1);
  ShowPersona(p1); cout << endl;
  cambioDeNombre("Pepito", p1);
  ShowPersona(p1); cout << endl;

  Persona p2 = consPersona("Maria", 30);
  Persona p3 = consPersona("Dario", 50);

  cout << esMayorQueLaOtra(p1, p1) << endl;
  cout << esMayorQueLaOtra(p1, p2) << endl;
  cout << esMayorQueLaOtra(p2, p3) << endl;
  cout << esMayorQueLaOtra(p2, p1) << endl;
  cout << esMayorQueLaOtra(p3, p1) << endl;
  cout << esMayorQueLaOtra(p3, p2) << endl;

  ShowPersona(laQueEsMayor(p1,p2));
  ShowPersona(laQueEsMayor(p2,p3));
}