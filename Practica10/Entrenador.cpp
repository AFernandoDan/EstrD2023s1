#include <iostream>
#include "Entrenador.h"
#include "Pokemon.h"
using namespace std;

struct EntrenadorSt {
  string nombre;
  Pokemon* pokemon;
  int cantPokemon;
};

// Dado un nombre, una cantidad de pokémon, y un array de pokémon de ese tamaño, devuelve
// un entrenador.
Entrenador consEntrenador(string nombre, int cantidad, Pokemon* pokemon) {
  EntrenadorSt* e = new EntrenadorSt;
  e->nombre = nombre;
  e->cantPokemon = cantidad;
  e->pokemon = pokemon; // ¿Hay que crear un nuevo array o puedo simplemente guardar el puntero?
  return e;
}

// Devuelve el nombre del entrenador.
string nombreDeEntrenador(Entrenador e) {
  return e->nombre;
}

// Devuelve la cantidad de pokémon que posee el entrenador.
int cantidadDePokemon(Entrenador e) {
  return e->cantPokemon;
}

// Devuelve la cantidad de pokémon de determinado tipo que posee el entrenador.
int cantidadDePokemonDe(TipoDePokemon tipo, Entrenador e) {
  int c = 0;
  for (int i = 0; i < e->cantPokemon; i++) {
    if (tipoDePokemon(e->pokemon[i]) == tipo) c++;
  }
  return c;
}

// Devuelve el pokémon número i de los pokémon del entrenador.
// Precondición: existen al menos i − 1 pokémon.
Pokemon pokemonNro(int i, Entrenador e) {
  return e->pokemon[i-1];
}

// Indica si el pokemon dado le gana a todos los del entrenador dado.
bool leGanaATodosP(Pokemon p, Entrenador e) {
  int i = 0;
  while (i < e->cantPokemon && superaA(p, e->pokemon[i])) {
    i++;
  }
  return i == e->cantPokemon;
}

// Dados dos entrenadores, indica si, para cada pokémon del segundo entrenador, el primero
// posee al menos un pokémon que le gane.
bool leGanaATodos(Entrenador e1, Entrenador e2) {
  int i = 0;
  while (i < e1->cantPokemon && !leGanaATodosP(e1->pokemon[i], e2)) {
    i++;
  }
  return i < e1->cantPokemon;
}