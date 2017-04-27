#include "levels.h"

void loadLevel(char levelIndex) {
  char i, j, tile;
  curLevel = levelIndex;

  for(i = 0; i < lcdHeight; i++) {
    for(j = 0; j < lcdWidth; j++) {
      //combineTiles(levels[curLevel][2*i][j], levels[curLevel][2*i+1][j]);
      tile = max(levels[curLevel][2*i][j], levels[curLevel][2*i+1][j]);
      Lcd_Chr(i+1, j+1, tile+1);
    }
  }
}

char getBlockId(char x, char y) {
  if(x < 0 || x > lcdWidth || y < 0 || y > lcdHeight) { return -1; }
  return levels[curLevel][y][x];
}
