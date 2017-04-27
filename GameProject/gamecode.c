#include "lcd.h"
#include "menu.h"
#include "levels.h"
#include "player.h"

typedef enum GameState{
  ST_MENU,
	ST_PAUSE,
	ST_INGAME
} GameState;
GameState gameState = ST_MENU;

void initialize();
void initPIC();
void changeGameState(GameState newState);
void update();

// Micro controller
static const char updateInterval = 50; // delay between each update();

void main() {
  initialize();

  changeGameState(ST_MENU);
  while(1) { update(); }
}

void initialize() {
  initPIC();
  initLCD();
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

void changeGameState(GameState newState) {
  if (newState == ST_MENU) {
    loadMenu();
  }
  if (gameState == ST_MENU && newState == ST_INGAME) {
    // loadLevel();
    initPlayer();
  }
  gameState = newState;
}

void update() {
  switch (gameState) {
    case ST_MENU:
      break;
    case ST_INGAME:
      updatePlayerSprite();
      break;
    case ST_PAUSE:
      break;
  }

  delay_ms(updateInterval);
}
