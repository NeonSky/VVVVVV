#ifndef PLAYER_H_
#define PLAYER_H_

#include "lcd.h"
#include "levels.h"

/*
    Declarations
*/
// User inputs
sbit gravityBtn at PORTC.B5;
sbit leftBtn at PORTC.B6;
sbit rightBtn at PORTC.B7;

// Datastructure to represents the player
struct Player {
  char x, y;
  char isAirborne, isFaceUp;
};
// Holds global player object
extern struct Player player;

/*
    Functions
*/

// Initializes player at the given position and direction
void initPlayer(char x, char y, char faceUp);

// Polls user input and moves player accordingly if the level permits it
//  i.e. no blocking tiles.
void movePlayer();

// Renders player to LCD display with combined tile
void updatePlayerSprite();

// Determines whether the player is airborne or not
void checkAirborne(signed char gravityDir);

// Clamps player position within LCD bounds
void clampPlayerPos();

// Based on players current position - determine any action associated with the tile
//  i.e. spike => ST_GAMEOVER
void checkCurTile();

// Performs check if the tile at the given position is travsersable or not
//  Returns 1 if travsersable
//  Returns 0 if not travsersable
char isTraversable(char x, char y);

/*
    Constants
*/
// Player sprites, used to represent different states of the player on the LCD
static const char playerSprites[][lcdCharLength] = {
  // Face-up, upper
  {0b00001010,
   0b00000000,
   0b00010001,
   0b00001110,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000},

   // Face-up, lower
  {0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00001010,
   0b00000000,
   0b00010001,
   0b00001110},

  // Face-down, upper
  {0b00001110,
   0b00010001,
   0b00000000,
   0b00001010,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000},

  // Face-down, lower
  {0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00001110,
   0b00010001,
   0b00000000,
   0b00001010}
};

#endif