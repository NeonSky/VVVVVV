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

/* delay between each update();
Can definitly be lower, but it's quite high due to better user experience. */
static const char updateInterval = 75;


// Initializes all hardware including the PIC and the LCD
void initialize();

// Initializes general I/O and configurations specific to the PIC
void initPIC();

// Function used for changing the current game state and any initialization
//    required between game state changes.
void changeGameState(GameState newState);

// Shortly shows the game over screen on the LCD. Called when the player dies.
void showGameOverScreen();

// Shortly shows the win screen on the LCD. Called when the last level is beat.
void showWinScreen();

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
    curLevel = -1;
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
    // Not implemented yet, but a pause screen could be displayed here.
    break;

  case ST_GOAL:
    // If there exists another level - transition to it,
    // if not - transition to menu state
    if (curLevel + 1 < levelCount) {
      loadLevel(curLevel + 1);
      //curLevel++;
    } else {
      showWinScreen();
      changeGameState(ST_MENU);
    }
    break;

  case ST_GAMEOVER:
    showGameOverScreen();
    changeGameState(ST_MENU);
    break;
  }
  delay_ms(updateInterval);
}

void showGameOverScreen() {
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Out(2, 5, "Game Over =(");
  Lcd_Out(3, 6, "Try again!");
  delay_ms(5000);
}

void showWinScreen() {
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Out(2, 3, "Congratulations!");
  Lcd_Out(3, 2, "Thanks for playing");
  delay_ms(5000);
}