#include "game_structs.h"

void definePlayerMe(player* whoAmI, pokemon* allPokemon, int pokemonOne, int pokemonTwo) {
  // Need "static"?
  static pokemon pokePartyMe[POKEMON_PARTY_SIZE];
  pokePartyMe[0] = allPokemon[pokemonOne];
  pokePartyMe[1] = allPokemon[pokemonTwo];
  whoAmI->pokemonParty = pokePartyMe;
  whoAmI->whichPokemon = 0;
  /* Don't want to modify Pokemon struct HP in case player gets two of the same Pokemon. Copy pokemon HP. */
  whoAmI->pokemon1HP = allPokemon[pokemonOne].hp;
  whoAmI->pokemon2HP = allPokemon[pokemonTwo].hp;
  /* Determine which HP to subtract from when Pokemon takes damage. */

}


void definePlayerOppo(player* whoAmI, pokemon* allPokemon, int pokemonOne, int pokemonTwo) {
  // Need "static"?
  static pokemon pokePartyOppo[POKEMON_PARTY_SIZE];
  pokePartyOppo[0] = allPokemon[pokemonOne];
  pokePartyOppo[1] = allPokemon[pokemonTwo];
  whoAmI->pokemonParty = pokePartyOppo;
  whoAmI->whichPokemon = 0;
  /* Don't want to modify Pokemon struct HP in case player gets two of the same Pokemon. Copy pokemon HP. */
  whoAmI->pokemon1HP = allPokemon[pokemonOne].hp;
  whoAmI->pokemon2HP = allPokemon[pokemonTwo].hp;
  /* Determine which HP to subtract from when Pokemon takes damage. */

}
