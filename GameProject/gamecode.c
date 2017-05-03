/*
  gamecode.c - holds implementation of general code execution and
  integration of the game.

  Authors: Anton Håkansson & Jacob Eriksson
  Date: 2017-05-03
*/

#include "gamestate.h"
#include "lcd.h"
#include "levels.h"
#include "menu.h"
#include "player.h"

// Holds current game state - holds a value described in gamestate.h
GameState gameState = ST_MENU;

// delay between each update();
static const char updateInterval = 50;


// Initializes all hardware including the PIC and the LCD
void initialize();

// Initializes general I/O and configurations specific to the PIC
void initPIC();

// Function used for changing the current game state and any initialization
//    required between game state changes.
void changeGameState(GameState newState);

// Game loop, called every updateInterval
//  Updates game state specific code
void update();

// Driver program
void main() {

  // Initialize hardware
  initialize();

  // Transition to Menu state
  changeGameState(ST_MENU);

  // Update
  while (1) {
    update();
  }
}

void initialize() {
  initPIC();
  initLCD();
}


void initPIC() {
  OSCCON = 0b01110111; // 8 MHz clock frequency
  ANSEL = 0b00000000;  // No analog inputs needed
  ANSELH = 0b00000000; // No analog inputs needed

  TRISA = 0b00000000; // PORTA outputs
  TRISB = 0b00000000; // PORTB outputs
  TRISC = 0xFF;       // PORTC Inputs
  PORTA = 0b00000000; // Reset PORTA
  PORTB = 0b00000000; // Reset PORTB
  PORTC = 0b00000000; // Reset PORTC
}

void changeGameState(GameState newState) {

  // If we're transitioning to Menu state - initialize menu
  if (newState == ST_MENU) {
    loadMenu();
    // Print selectable levels 0-3 ( needed here because of limited call stack )
    printSelectableLevels(0);
  }

  // Update game state
  gameState = newState;
}

void update() {
  switch (gameState) {
  case ST_MENU:
    updateMenu();
    break;

  case ST_INGAME:
    movePlayer();
    break;

  case ST_PAUSE:
    break;

  case ST_GOAL:
    // If there exists another level - transition to it,
    // if not - transition to menu state
    if (curLevel + 1 < levelCount) {
      loadLevel(curLevel + 1);
    } else {
      changeGameState(ST_MENU);
    }
    break;

  case ST_GAMEOVER:
    // TODO: Play gameover scene
    changeGameState(ST_MENU);
    break;
  }
  delay_ms(updateInterval);
}
