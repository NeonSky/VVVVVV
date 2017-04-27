#ifndef PLAYER_H_
#define PLAYER_H_

#include "lcd.h"
#include "levels.h"

/*
    Declarations
*/
sbit gravityBtn at PORTC.B5;
sbit leftBtn at PORTC.B6;
sbit rightBtn at PORTC.B7;

struct Player {
  char x;
  char y;
  char isAirborne;
  short isFaceUp;
};
extern struct Player player;


/*
    Functions
*/
void initPlayer();
void updatePlayerChar(char playerState, char tileId);
void drawPlayer();
void checkAirborne();


/*
    Constants
*/
static const char playerStates[][lcdCharLength] = {
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
