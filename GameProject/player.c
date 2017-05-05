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
      delay_ms(50);
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
  // Get the tile id of the tile that the player shares the same LCD cell with
  short tileId = getTileId(player.x, player.y - 1 + 2*(player.y % 2));
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
  else if (tileId == spikeUU || tileId == spikeLU || tileId == spikeUD || tileId == spikeLD) {
    changeGameState(ST_GAMEOVER);
  }
}

char isTraversable(char x, char y) {
  char tileId = getTileId(x, y);
  return (tileId == air || tileId == start || tileId == goal ||
          ((tileId == spikeUU || tileId == spikeLU) && player.isFaceUp) ||
          ((tileId == spikeUD || tileId == spikeLD) && !player.isFaceUp));
}