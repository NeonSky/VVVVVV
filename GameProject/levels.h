#ifndef LEVELS_H_
#define LEVELS_H_

#include "lcd.h"


/*
    Functions
*/
void loadLevel(char levelIndex);
short getTileId(char x, char y);



/*
    Constants
*/
static char curLevel = 0;
static const char levels[][lcdHeight*2][lcdWidth] = {
  // Level 1
 {{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},  // Row 1 (upper)
  {5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},  // Row 1 (lower)

  {1,1,1,1,1,1,1,1,3,3,3,3,1,1,1,1,1,1,1,0},  // Row 2 (upper)
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},  // Row 2 (lower)

  {0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,3,3,1,1},  // Row 3 (upper)
  {0,2,2,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0},  // Row 3 (lower)

  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,1},  // Row 4 (upper)
  {2,2,0,0,0,0,2,2,2,2,2,2,4,4,4,2,2,2,2,2}}, // Row 4 (lower)

  // Level 2
 {{3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3},
  {6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},

  {3,3,3,3,3,3,3,3,5,5,5,5,3,3,3,3,3,3,3,3},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},

  {0,0,0,0,0,0,0,3,3,3,3,3,3,3,3,3,4,4,3,3},
  {0,3,3,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0},

  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7},
  {3,3,0,0,0,0,3,3,3,3,3,3,4,4,4,3,3,3,3,3}}
};
static const char levelCount = sizeof(levels) / sizeof(levels[0]);

// Tiles used in the game
enum Tile {
  undefined = -1,
  air = 0,
  halfBlockU = 1,
  halfBlockL = 2,
  spikeU = 3,
  spikeD = 4,
  start = 5,
  goal = 6
};

// Tile sprites, used to represent the various of tiles on the LCD
static const char tileSprites[][lcdCharLength] = {
  // Air
  {0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000},

  // Half block, upper
  {0b00011111,
   0b00011111,
   0b00011111,
   0b00011111,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000},

  // Half block, lower
  {0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00011111,
   0b00011111,
   0b00011111,
   0b00011111},

  // Spike, upper
  {0b00011111,
   0b00001110,
   0b00000100,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000},

  // Spike, lower
  {0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000100,
   0b00001110,
   0b00011111},

  // Start
  {0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000},

  // Goal
  {0b00000000,
   0b00000000,
   0b00000100,
   0b00001110,
   0b00001110,
   0b00000100,
   0b00000000,
   0b00000000},
};
static const char tileCount = sizeof(tileSprites) / sizeof(tileSprites[0]);

#endif
