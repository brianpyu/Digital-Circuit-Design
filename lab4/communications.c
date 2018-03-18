#include "auxillary_functions.h"
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
//#include "sys/alt_stdio.h"

void send(char data) {
   volatile int i;
	*PARALLEL_SEND = data;
   *LOAD = 1;
   for(i = 0; i < 100000; i++){}

   *TRANSMIT = 1;
   *LOAD = 0;              // Maybe too fast? Add delay?
   while (!(*CHAR_SENT & 0b1)) {
   	continue;
   }
   for(i = 0; i < 10000; i++){}
   printf("parallel send : %d \n", *PARALLEL_SEND);

   *TRANSMIT = 0;
}

char receive() {
   bool received;
   received = false;
   printf("parallel rec bef : %d \n", *PARALLEL_RECEIVE);
   while(*CHAR_RECEIVED) {
//	   printf("*CHAR_RECEIVED bef : %d \n", *CHAR_RECEIVED);
   }


   printf("parallel rec mid : %d \n", *PARALLEL_RECEIVE);
   while(!*CHAR_RECEIVED) {
//	   printf("*CHAR_RECEIVED mid : %d \n", *CHAR_RECEIVED);
   }
   printf("parallel rec after: %d \n", *PARALLEL_RECEIVE);
   return *PARALLEL_RECEIVE;
//  printf("OPPO INPUT:\n");
//  int myAnswer;
//  do
//    myAnswer = alt_getchar();
//  while(isspace(myAnswer));
//  printf("oppo inputed: %d\n", myAnswer - '0');
//  return  myAnswer - '0';
}

void sendInfoToOpponent(player* whoAmI) {
  player thePlayer = *whoAmI;
  int pokemonOne = thePlayer.pokemonParty[0].numValue;
  int pokemonTwo = thePlayer.pokemonParty[1].numValue;
  send((pokemonOne << 3) + (pokemonTwo));
}

void receiveInfoFromOpponent(player *oppo, pokemon* allPokemon) {
  int received = receive();
  int pokeOne = (received & 0b111000) >> 3;
  int pokeTwo = received & 0b111;
  printf("received %d\n", received);
  definePlayerOppo(oppo, allPokemon, pokeOne, pokeTwo);
}

bool rockPaperScissor() {
  bool done = false;
  while (!done) {

	printf("Rock, Paper, Scissor! (Rock = 1,  Paper = 2,  Scissor = 3)\n");
    int myAnswer;
    do
      myAnswer = alt_getchar();
    while(isspace(myAnswer));
    myAnswer -= '0';
    if (myAnswer < 1 || myAnswer > 3) {
      printf("Please enter a valid answer! (Rock = 1,  Paper = 2,  Scissor = 3)\n");
      continue;
    }

    send(myAnswer);

	int opponentAnswer = receive();

    if (myAnswer == opponentAnswer) {
      printf("Tie.\n");
      continue;
    }

    if (myAnswer % 3 + 1 == opponentAnswer) {
      return false;
    } else {
      return true;
    }
  }
}
