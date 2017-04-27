#include "lcd.h"
#include "levels.h"
#include "player.h"

void initialize();
void initPIC();
void initGame();
void update();

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

void initGame() {
  initPlayer();
}

void initPIC() {
  OSCCON = 0b01110111; // 8 MHz
  ANSEL = 0b00000000;
  ANSELH = 0b00000000;

  TRISA = 0b00000000;
  TRISB = 0b00000000;
  TRISC = 0b00000000;
  PORTA = 0b00000000;
  PORTB = 0b00000000;
  PORTC = 0b00000000;
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

  signed char player_dir = player.isFaceUp == 1 ? -1 : 1;
  char player_state = player.y % 2 + 2*(1-player.isFaceUp);
  updatePlayerChar(player_state, levels[curLevel][player.y-player_dir][player.x]);
  drawPlayer();

  delay_ms(50);
}
