#include <stdio.h>
#include <system.h>
#include "sys/alt_stdio.h"
#define characterSent (volatile char *) CHARACTERSENT_BASE
#define characterReceived (volatile char *) CHARACTERRECEIVED_BASE
#define load (volatile char *) LOAD_BASE
#define transmitEnable (volatile char *) TRANSMITENABLE_BASE
#define parallelInput (volatile char *) PARALLELINPUT_BASE
#define parallelOutput (volatile char *) PARALLELOUTPUT_BASE
#define writeEnable (volatile char *) WRITEENABLE_BASE
#define outputEnable (volatile char *) OUTPUTENABLE_BASE
#define data (volatile char *) DATA_BASE
#define address (volatile char *) ADDRESS_BASE

int main(){

	while(1){
		*transmitEnable = 1;
		*parallelOutput = alt_getchar();
		*load = 1;
		printf("parallelOutput: %d\n", *parallelOutput);
		//printf("characterSent: %d\n", *characterSent);
		//printf("characterReceived: %d\n", *characterReceived);
		//printf("load: %d\n", *load);
		//printf("transmitEnable: %d\n", *transmitEnable);
		*load = 0;
		//printf("\n");
		//printf("characterSent: %d\n", *characterSent);
		while(!*characterSent){
			continue;
		}
		while ((alt_getchar()) != '\n');

		//printf("characterSent: %d\n", *characterSent);
		//printf("characterReceived: %d\n", *characterReceived);
		//printf("\n");
		while(!*characterReceived){
			printf("rec %d\n",*characterReceived );
			continue;
		}
		*transmitEnable = 0;
		*load = 0;
		//printf("characterReceived: %d\n", *characterReceived);
		printf("parallelInput: %c\n", (char)*parallelInput);
		printf("\n");
	}
}
