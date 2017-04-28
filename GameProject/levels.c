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
      tile = loadTile(j+1, i+1);
      if(tile == start) {
        if(levels[curLevel][2*i][j] == start) {
          playerX = j+1;
          playerY = 2*i+1;
        } else {
          playerX = j+1;
          playerY = (2*i)+2;
        }
      }
    }
  }

  initPlayer(playerX, playerY, 1);
  changeGameState(ST_INGAME);
}

char loadTile(char x, char y) {
  char upperTile = levels[curLevel][2*(y-1)][x-1];
  char lowerTile = levels[curLevel][2*(y-1)+1][x-1];
  char priorityTile = max(upperTile, lowerTile);
  
  if(priorityTile == start) { Lcd_Chr(y, x, 1+min(upperTile, lowerTile)); }
  else { Lcd_Chr(y, x, 1+priorityTile); }
  return priorityTile;
}

short getTileId(char x, char y) {
  if(x < 1 || x > lcdWidth || y < 1 || y > lcdHeight*2) { return -1; }
  return levels[curLevel][y-1][x-1];
}

char isTraversable(char x, char y) {
  char tileId = getTileId(x, y);
  return (tileId == air || tileId == start || tileId == goal || tileId == spikeU || tileId == spikeD);
}