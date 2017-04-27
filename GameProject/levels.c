#include "levels.h"

void loadLevel(char levelIndex) {
  char i, j, tile;
  curLevel = levelIndex;

  // Clear screen
  Lcd_Cmd (_LCD_CLEAR);

  // Print Level
  for(i = 0; i < lcdHeight; i++) {
    for(j = 0; j < lcdWidth; j++) {
      tile = max(levels[curLevel][2*i][j], levels[curLevel][2*i+1][j]);
      Lcd_Chr(i+1, j+1, tile+1);
    }
  }
}

char getTileId(char x, char y) {
  if(x < 0 || x > lcdWidth || y < 0 || y > lcdHeight) { return -1; }
  return levels[curLevel][y-1][x-1];
}
