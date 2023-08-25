#include <iostream>
using namespace std;
#include "Pokemon.h"
#include "Entrenador.h"

void ShowPokemon(Pokemon p) {
  cout << "Pokemon[" << p << "]("; 
  cout << "tipo <- \"" << tipoDePokemon(p) << "\", ";
  cout << "energia <- " << energia(p);
  cout << ")" << endl;
}

void ShowEntrenador(Entrenador e) {
  cout << "Entrenador[" << e << "]("; 
  cout << "nombre <- \"" << nombreDeEntrenador(e) << "\", ";
  cout << "cantPokemon <- " << cantidadDePokemon(e) << "\", ";
  cout << "pokemones <- [" << endl;
  for (int i = 0; i < cantidadDePokemon(e); i++) {
    ShowPokemon(pokemonNro(i+1, e));
    cout << "\", " << endl;
  }
  cout << "]";
  cout << ")" << endl;
}

int main() {
  Pokemon p1 = consPokemon("Agua");
  ShowPokemon(p1); cout << endl;
  perderEnergia(10, p1);
  ShowPokemon(p1); cout << endl;
  perderEnergia(10, p1);
  ShowPokemon(p1); cout << endl;

  Pokemon p2 = consPokemon("Fuego");
  Pokemon p3 = consPokemon("Planta");

  cout << superaA(p1, p1) << endl;
  cout << superaA(p1, p2) << endl;
  cout << superaA(p2, p3) << endl;
  cout << superaA(p2, p1) << endl;
  cout << superaA(p3, p1) << endl;
  cout << superaA(p3, p2) << endl;

  Pokemon p4 = consPokemon("Fuego");
  Pokemon p5 = consPokemon("Planta");
  Pokemon p6 = consPokemon("Agua");

  Pokemon* pokemones1 = new Pokemon[3];
  pokemones1[0] = p1;
  pokemones1[1] = p2;
  pokemones1[2] = p3;

  Pokemon* pokemones2 = new Pokemon[3];
  pokemones2[0] = p4;
  pokemones2[1] = p5;
  pokemones2[2] = p6;

  Pokemon* pokemones3 = new Pokemon[0];

  Entrenador ash = consEntrenador("Ash", 3, pokemones1);
  Entrenador misty = consEntrenador("Misty", 3, pokemones2);
  Entrenador brock = consEntrenador("Brock", 0, pokemones3);

  ShowEntrenador(ash);
  ShowEntrenador(misty);
  ShowEntrenador(brock);

  cout << "leGanaATodos(ash, misty): "<< endl;
  cout << leGanaATodos(ash, misty) << endl;

  cout << "leGanaATodos(ash, brock): "<< endl;
  cout << leGanaATodos(ash, brock) << endl;

  cout << "leGanaATodos(misty, brock): "<< endl;
  cout << leGanaATodos(misty, brock) << endl;

  Pokemon* pokemones4 = new Pokemon[3];
  pokemones4[0] = p2;
  pokemones4[1] = p2;
  pokemones4[2] = p2;
  Entrenador may = consEntrenador("May", 3, pokemones4);

  cout << "leGanaATodos(ash, may): "<< endl;
  cout << leGanaATodos(ash, may) << endl;

  cout << "leGanaATodos(may, ash): "<< endl;
  cout << leGanaATodos(may, ash) << endl;

  cout << "leGanaATodos(misty, may): "<< endl;
  cout << leGanaATodos(misty, may) << endl;
}