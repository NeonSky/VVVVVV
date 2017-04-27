#include "player.h"

struct Player player = {1, 1, 0, 1};

void initPlayer() {
  player.isAirborne = 0;
  player.isFaceUp = 1;
}

void movePlayer() {
  signed char gravityDir = (player.isFaceUp == 1) ? -1 : 1;
  checkAirborne(gravityDir);

  // Airborne movement
  if(player.isAirborne) {
    player.y += gravityDir;
    clampPlayerPos();
    return;
  }

  // Ground movement
  if(leftBtn) {
    if(getTileId(player.x-1, player.y) == air) { player.x--; }
  }
  else if(rightBtn) {
    if(getTileId(player.x+1, player.y) == air) { player.x++; }
  }
  else if(gravityBtn) {
    isFaceUp = ~isFaceUp;
  }
  clampPlayerPos();
  updatePlayerSprite();
}

void clampPlayerPos() {
  if(player.y < 0) { player.y = 0; }
  else if(player.y > lcdHeight) { player.y = lcdHeight; }
  if(player.x < 0) { player.x = 0; }
  else if(player.x > lcdWidth) { player.x = lcdWidth; }
}

void updatePlayerSprite() {
  char i;
  signed char gravityDir = (player.isFaceUp == 1) ? -1 : 1;
  char tileId = getTileId(player.x, player.y - gravityDir);
  char playerState = player.y % 2 + 2*(1-player.isFaceUp);
  char combinedTile[lcdCharLength];

  for(i = 0; i < lcdCharLength; i++) {
    combinedTile[i] = playerSprites[playerState][i] | tileSprites[tileId][i];
  }

  Lcd_Cmd(charEntryMemory);
  for(i = 0; i < lcdCharLength; i++) { Lcd_Chr_Cp(combinedTile[i]); }
  Lcd_Cmd(_LCD_RETURN_HOME);
  Lcd_Chr((player.y-1)/2 + 1, player.x, 0);
}

void checkAirborne(signed char gravityDir) {
  char below = getTileId(player.x, player.y + gravityDir);

  if(below == air ||
    (below == spikeU && player.isFaceUp == 1) ||
    (below == spikeD && player.isFaceUp == 0)) {
    player.isAirborne = 1;
  }
  player.isAirborne = 0;
}
