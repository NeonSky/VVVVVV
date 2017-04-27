#line 1 "Z:/home/batman/git/VVVVVV/GameProject/levels.c"
#line 1 "z:/home/batman/git/vvvvvv/gameproject/levels.h"
#line 1 "z:/home/batman/git/vvvvvv/gameproject/lcd.h"
#line 9 "z:/home/batman/git/vvvvvv/gameproject/lcd.h"
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;
#line 26 "z:/home/batman/git/vvvvvv/gameproject/lcd.h"
void initLCD();
#line 32 "z:/home/batman/git/vvvvvv/gameproject/lcd.h"
static const char lcdWidth = 20;
static const char lcdHeight = 4;
static const char lcdCharLength = 8;
static const char charEntryMemory = 64;
#line 10 "z:/home/batman/git/vvvvvv/gameproject/levels.h"
void loadLevel(char levelIndex);
short getTileId(char x, char y);
#line 18 "z:/home/batman/git/vvvvvv/gameproject/levels.h"
static char curLevel = 0;
static const char levels[][lcdHeight*2][lcdWidth] = {

 {{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
 {5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},

 {1,1,1,1,1,1,1,1,3,3,3,3,1,1,1,1,1,1,1,0},
 {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},

 {0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,3,3,1,1},
 {0,2,2,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0},

 {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,1},
 {2,2,0,0,0,0,2,2,2,2,2,2,4,4,4,2,2,2,2,2}},


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


static const char tileSprites[][lcdCharLength] = {

 {0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000},


 {0b00011111,
 0b00011111,
 0b00011111,
 0b00011111,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000},


 {0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00011111,
 0b00011111,
 0b00011111,
 0b00011111},


 {0b00011111,
 0b00001110,
 0b00000100,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000},


 {0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000100,
 0b00001110,
 0b00011111},


 {0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000},


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
#line 1 "z:/home/batman/git/vvvvvv/gameproject/gamestate.h"



typedef enum GameState {
 ST_MENU,
 ST_PAUSE,
 ST_INGAME,
 ST_GOAL,
 ST_GAMEOVER
} GameState;
extern GameState gameState;

void changeGameState(GameState newState);
#line 1 "z:/home/batman/git/vvvvvv/gameproject/player.h"
#line 1 "z:/home/batman/git/vvvvvv/gameproject/lcd.h"
#line 1 "z:/home/batman/git/vvvvvv/gameproject/levels.h"
#line 11 "z:/home/batman/git/vvvvvv/gameproject/player.h"
sbit gravityBtn at PORTC.B5;
sbit leftBtn at PORTC.B6;
sbit rightBtn at PORTC.B7;

struct Player {
 char x, y;
 char isAirborne, isFaceUp;
};
extern struct Player player;
#line 25 "z:/home/batman/git/vvvvvv/gameproject/player.h"
void initPlayer(char x, char y, char faceUp);
void movePlayer();
void updatePlayerSprite();
void checkAirborne(signed char gravityDir);
void clampPlayerPos();
void playerDied();
void checkCurTile();
#line 38 "z:/home/batman/git/vvvvvv/gameproject/player.h"
static const char playerSprites[][lcdCharLength] = {

 {0b00001010,
 0b00000000,
 0b00010001,
 0b00001110,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000},


 {0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00001010,
 0b00000000,
 0b00010001,
 0b00001110},


 {0b00001110,
 0b00010001,
 0b00000000,
 0b00001010,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00000000},


 {0b00000000,
 0b00000000,
 0b00000000,
 0b00000000,
 0b00001110,
 0b00010001,
 0b00000000,
 0b00001010}
};
#line 6 "Z:/home/batman/git/VVVVVV/GameProject/levels.c"
void loadLevel(char levelIndex) {
 char i, j, tile, playerX = 1, playerY = 1;
 curLevel = levelIndex;


 Lcd_Cmd (_LCD_CLEAR);


 for(i = 0; i < lcdHeight; i++) {
 for(j = 0; j < lcdWidth; j++) {
 tile = max(levels[curLevel][2*i][j], levels[curLevel][2*i+1][j]);
 if(tile == start) {
 playerX = j+1;
 playerY = i+1;
 }
 Lcd_Chr(i+1, j+1, tile+1);
 }
 }

 initPlayer(playerX, playerY, 1);
 changeGameState(ST_INGAME);
}

short getTileId(char x, char y) {
 if(x < 0 || x > lcdWidth || y < 0 || y > lcdHeight) { return -1; }
 return levels[curLevel][y-1][x-1];
}
