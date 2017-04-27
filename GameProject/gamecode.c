#include "lcd.h"
#include "levels.h"
#include "player.h"

void initialize();
void initPIC();
void initGame();
void update();

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
  /*checkAirborne();
  if(!player.isAirborne) {
    if(leftBtn) {
      if(getBlock(player.x-1, player.y) == air) {
        player.x--;
      }
    }
    else if(rightBtn) {
      if(getBlock(player.x+1, player.y) == air) {
        player.x++;
      }
    }
    else if(gravityBtn) {
      isFaceUp = ~isFaceUp;
    }
  }
  if(isAirborne) { player.y--; }
  //checkCurTile(); // Check for goal, spikes etc.    */

  /*if(player.y % 2 == 0) {
    if(player.isFaceUp) {
      updatePlayerChar(0, levels[curLevel][player.y+1][player.x]);
    } else {
      updatePlayerChar(2, levels[curLevel][2*player.y+1][player.x]);
    }
  } else {
    if(player.isFaceUp) {
      updatePlayerChar(1, levels[curLevel][2*player.y][player.x]);
    } else {
      updatePlayerChar(3, levels[curLevel][2*player.y][player.x]);
    }
  }*/

  updatePlayerSprite();
  delay_ms(updateInterval);
}
