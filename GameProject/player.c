#include "player.h"

struct Player player = {0, 1, 0, 1};

void initPlayer() {
  player.isAirborne = 0;
  player.isFaceUp = 1;
}

void updatePlayerChar(char playerState, char tileId) {
  char it;
  char combinedTile[lcdCharLength];
  for(it = 0; it < lcdCharLength; it++) {
    combinedTile[it] = playerStates[playerState][it] | tiles[tileId][it];
  }

  Lcd_Cmd(64);
  for(it = 0; it < lcdCharLength; it++) { Lcd_Chr_Cp(combinedTile[it]); }
  Lcd_Cmd(_LCD_RETURN_HOME);
}

void drawPlayer() {
  Lcd_Chr(player.y/2 + 1, player.x + 1, 0);
}

void checkAirborne() {
  short offset;
  char below;
  offset = player.isFaceUp == 1 ? -1 : 1;
  below = getBlockId(player.x, player.y+offset);
  if(below == air ||
    (below == spikeU && player.isFaceUp == 1) ||
    (below == spikeD && player.isFaceUp == 0)) {
    player.isAirborne = 1;
  }
  player.isAirborne = 0;
}
