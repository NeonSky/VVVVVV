#include "player.h"

struct Player player = {0, 1, 0, 1};

void initPlayer() {
  player.isAirborne = 0;
  player.isFaceUp = 1;
}

void updatePlayerSprite() {
  char i;
  char tileId = getTileId(player.x, player.y-playerDir);
  signed char playerDir = (player.isFaceUp == 1) ? -1 : 1;
  char playerState = player.y % 2 + 2*(1-player.isFaceUp);
  char combinedTile[lcdCharLength];

  for(i = 0; i < lcdCharLength; i++) {
    combinedTile[i] = playerSprites[playerState][i] | tileSprites[tileId][i];
  }

  Lcd_Cmd(charEntryMemory);
  for(i = 0; i < lcdCharLength; i++) { Lcd_Chr_Cp(combinedTile[i]); }
  Lcd_Cmd(_LCD_RETURN_HOME);
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
