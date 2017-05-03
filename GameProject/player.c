#include "player.h"
#include "gamestate.h"
#include "levels.h"

struct Player player;

void initPlayer(char x, char y, char faceUp) {
  player.x = x;
  player.y = y;
  player.isAirborne = 0;
  player.isFaceUp = faceUp;
}

void movePlayer() {
  signed char gravityDir = player.isFaceUp == 1 ? 1 : -1;
  checkAirborne(gravityDir);

  /*lcd_chr(4, 14, '0'+player.x);
  lcd_chr(4, 16, '0'+player.y);
  lcd_chr(4, 18, '0'+player.isAirborne);
  lcd_chr(4, 20, '0'+player.isFaceUp);*/

  // Clear player sprite
  loadTile(player.x, (player.y - 1) / 2 + 1);

  if (player.isAirborne) {
    player.y += gravityDir;
  }
  else {
    // Ground movement
    if (leftBtn) {
      if (isTraversable(player.x - 1, player.y)) {
        player.x--;
      }
    }
    else if (rightBtn) {
      if (isTraversable(player.x + 1, player.y)) {
        player.x++;
      }
    }
    else if (gravityBtn) {
      player.isFaceUp = !player.isFaceUp;
    }
  }

  clampPlayerPos();
  updatePlayerSprite();
  checkCurTile();
}

// Clamp player position in bounds of the LCD screen
void clampPlayerPos() {
  if (player.y < 1) {
    player.y = 1;
  }
  else if (player.y > lcdHeight * 2) {
    player.y = lcdHeight * 2;
  }
  if (player.x < 1) {
    player.x = 1;
  }
  else if (player.x > lcdWidth) {
    player.x = lcdWidth;
  }
}

void updatePlayerSprite() {
  char i;

  short gravityDir = (player.isFaceUp == 1) ? -1 : 1;
  short tileId = getTileId(player.x, player.y - (1 - player.y % 2));
  char playerSprite;
  char combinedTile[lcdCharLength];

  if (player.y % 2 == 0) {
    if (player.isFaceUp) {
      playerSprite = 1;
    }
    else {
      playerSprite = 3;
    }
  }
  else {
    if (player.isFaceUp) {
      playerSprite = 0;
    }
    else {
      playerSprite = 2;
    }
  }

  // Combine player sprite with upper/lower tile sprite
  for (i = 0; i < lcdCharLength; i++) {
    combinedTile[i] = playerSprites[playerSprite][i] | tileSprites[tileId][i];
  }

  // Write combined tile to LCD display's CGRAM
  Lcd_Cmd(charEntryMemory);
  for (i = 0; i < lcdCharLength; i++) {
    Lcd_Chr_Cp(combinedTile[i]);
  }
  Lcd_Cmd(_LCD_RETURN_HOME);

  // Draw player sprite to LCD screen
  Lcd_Chr((player.y - 1) / 2 + 1, player.x, 0);
}

// Check if the player is falling or not
void checkAirborne(signed char gravityDir) {
  short below = getTileId(player.x, player.y + gravityDir);
  if (below == undefined) {
    changeGameState(ST_GAMEOVER);
    return;
  }
  player.isAirborne = isTraversable(player.x, player.y + gravityDir);
}

// Check current tile for objectives and dangers
void checkCurTile() {
  short tileId = getTileId(player.x, player.y);
  if (tileId == goal) {
    changeGameState(ST_GOAL);
  }
  else if (tileId == spikeU || tileId == spikeD) {
    changeGameState(ST_GAMEOVER);
  }
}
