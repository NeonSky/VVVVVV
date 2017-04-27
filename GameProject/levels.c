#include "levels.h"
#include "gamestate.h"
#include "player.h"

// Displays a level to the LCD
void loadLevel(char levelIndex) {
  char i, j, tile, playerX = 1, playerY = 1;
  curLevel = levelIndex;

  // Clear screen
  Lcd_Cmd (_LCD_CLEAR);

  // Print Level
  for(i = 0; i < lcdHeight; i++) {
    for(j = 0; j < lcdWidth; j++) {
      tile = max(levels[curLevel][2*i][j], levels[curLevel][2*i+1][j]);
      if(tile == start) {
        playerX = j+1;
        playerY = i+1;
      }
      Lcd_Chr(i+1, j+1, tile+1);
    }
  }

  initPlayer(playerX, playerY, 1);
  changeGameState(ST_INGAME);
}

short getTileId(char x, char y) {
  if(x < 0 || x > lcdWidth || y < 0 || y > lcdHeight) { return -1; }
  return levels[curLevel][y-1][x-1];
}
