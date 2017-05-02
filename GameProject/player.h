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

struct Player {
  char x, y;
  char isAirborne, isFaceUp;
};
extern struct Player player;

/*
    Functions
*/
void initPlayer(char x, char y, char faceUp);
void movePlayer();
void updatePlayerSprite();
void checkAirborne(signed char gravityDir);
void clampPlayerPos();
void playerDied();
void checkCurTile();

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
