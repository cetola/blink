#include <stdio.h>
#include "superBlink.h"

void delay(int millisec) {
    return;
}

int main() {
    int err = 0;
    int ledNum = 0;
    int colors[NUM_LEDS] = {GREEN_LED, RED_LED, BLUE_LED};

    setupGPIO();

    while(!err) {
        setLED(colors[ledNum], ON);
        delay(DELAY);
        err = setLED(colors[ledNum++], OFF);
        delay(DELAY);

        if(ledNum >= NUM_LEDS) {
            ledNum = 0;
        }
    }
}