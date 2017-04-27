#include "lcd.h"
#include "levels.h"
#include "player.h"

// Game states, used for various game screens
typedef enum GameState {
  ST_MENU,
	ST_PAUSE,
	ST_INGAME,
  ST_GAMEOVER
} GameState;
GameState gameState = ST_MENU;

// Function declarations
void initialize();
void initPIC();
void update();
void goalReached();

// Micro controller
static const char updateInterval = 50; // delay between each update();


// Driver program
void main() {
  initialize();
  loadLevel(0);
  while(1) { update(); }
}

void initialize() {
  initPIC();
  initLCD();
  initPlayer();
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
  if(gameState == ST_MENU && newState == ST_INGAME) {
    // loadLevel();
  }
  gameState = newState;
}

// Game loop, called every update interval
void update() {
  switch(gameState) {
    case ST_MENU:
      break;
    case ST_INGAME:
      movePlayer();
      break;
    case ST_PAUSE:
      break;
  }
  delay_ms(updateInterval);
}

void gameOver() {
  changeGameState(ST_GAMEOVER);
}

void goalReached() {
  // Woo!
}
