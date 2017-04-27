#include "lcd.h"
#include "levels.h"
#include "player.h"

void initialize();
void initPIC();
void initGame();
void update();
void goalReached();

// Micro controller
static const char updateInterval = 50; // delay between each update();

void main() {
  initialize();
  loadLevel(0);
  while(1) { update(); }
}

void initialize() {
  initPIC();
  initLCD();
  initGame();
}

void initPIC() {
  OSCCON = 0b01110111; // 8 MHz clock frequency
  ANSEL = 0b00000000;  // No analog inputs needed
  ANSELH = 0b00000000; // No analog inputs needed

  TRISA = 0b00000000;  // PORTA outputs
  TRISB = 0b00000000;  // PORTB outputs
  TRISC = 0b00000000;  // PORTC outputs and inputs on F5-7
  PORTA = 0b00000000;  // Reset PORTA
  PORTB = 0b00000000;  // Reset PORTB
  PORTC = 0b00000000;  // Reset PORTC
}

void initGame() {
  initPlayer();
}

void update() {
  movePlayer();
  if(getBlockId(player.y+1, player.x+1) == goal) { goalReached(); }
  delay_ms(updateInterval);
}

void goalReached() {
  // Woo!
}
