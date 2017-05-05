#ifndef LEVELS_H_
#define LEVELS_H_

#include "lcd.h"

/*
    Functions
*/

// Loads and draws level to LCD
//  where levelIndex indicates the level to display
void loadLevel(char levelIndex);

// Loads and displays tile
char loadTile(char x, char y);

// Returns the id (see enum Tile) of the tile at the given position
short getTileId(char x, char y);

/*
    Constants
*/

// Tiles used in the game
enum Tile {
  start = -2,
  undefined = -1,
  air = 0,
  halfBlockU = 1,
  halfBlockL = 2,
  spikeUU = 3,
  spikeLU = 4,
  spikeUD = 5,
  spikeLD = 6,
  goal = 7
};

// Holds index of the currently drawn level
extern char curLevel;

// This array stores each level and their composition of tiles
//   The values represents a tile according to the Tile enum
static const char levels[][lcdHeight * 2][lcdWidth] = {
    // Level 1
    {{1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1},
     {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},

     {1, 1, 1, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
     {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0},

     {0, 0, 0, 0, 0, 0, 0, 1, 1, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1},
     {0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},

     {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0},
     {2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 4, 4, 4, 2, 2, 2, 2, 2}},

    // Level 2
    {{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 1, 0, 0, 1, 1, 1, 1},
     {0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0},

     {1, 1, 1, 0, 0, 3, 0, 1, 1, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0},
     {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0},

     {0, 0, 0, 0, 0, 1, 1, 0, 0, 3, 3, 1, 1, 0, 0, 0, 1, 1, 0, 1},
     {0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},

     {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0},
     {2, 2, 0, 0, 0, 0, 2, 2, 2, 4, 2, 2, 0, 0, 0, 2, 2, 2, 2, 2}}
};

static const char levelCount = sizeof(levels) / sizeof(levels[0]);

// Tile sprites, used to represent the various of tiles on the LCD
//  where the index of each tile follows the layout of the Tile enum.
//  Also used for combining new temporary tile with the player sprite
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

  // Spike, upper, face-up
  {0b00000000,
   0b00000100,
   0b00001110,
   0b00011111,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000},

  // Spike, lower, face-up
  {0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000100,
   0b00001110,
   0b00011111},
   
  // Spike, upper, face-down
  {0b00011111,
   0b00001110,
   0b00000100,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000},
   
  // Spike, lower, face-down
  {0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00011111,
   0b00001110,
   0b00000100,
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