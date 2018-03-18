#include <system.h>
#define switches (volatile char *) SWITCH_PIO_BASE
#define leds (volatile char *) LED_PIO_BASE
// turns on the LED corresponding to the switch
int main() {

	while (1) {


		*leds = *switches;

	}
	return 0;
}


