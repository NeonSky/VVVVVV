#line 1 "Z:/home/batman/git/VVVVVV/GameProject/player.c"
#line 1 "z:/home/batman/git/vvvvvv/gameproject/player.h"
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
#line 1 "z:/home/batman/git/vvvvvv/gameproject/levels.h"
#line 1 "z:/home/batman/git/vvvvvv/gameproject/lcd.h"
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
#line 4 "Z:/home/batman/git/VVVVVV/GameProject/player.c"
struct Player player;

void initPlayer(char x, char y, char faceUp) {
 player.x = x;
 player.y = y;
 player.isAirborne = 0;
 player.isFaceUp = faceUp;
}

void movePlayer() {
 signed char gravityDir = (player.isFaceUp == 1) ? -1 : 1;
 checkAirborne(gravityDir);


 if(player.isAirborne) {
 player.y += gravityDir;
 clampPlayerPos();
 return;
 }


 if(leftBtn) {
 if(getTileId(player.x-1, player.y) == air) { player.x--; }
 }
 else if(rightBtn) {
 if(getTileId(player.x+1, player.y) == air) { player.x++; }
 }
 else if(gravityBtn) {
 player.isFaceUp = ~player.isFaceUp;
 }

 clampPlayerPos();
 updatePlayerSprite();
 checkCurTile();
}


void clampPlayerPos() {
 if(player.y < 1) { player.y = 1; }
 else if(player.y > lcdHeight) { player.y = lcdHeight; }
 if(player.x < 1) { player.x = 1; }
 else if(player.x > lcdWidth) { player.x = lcdWidth; }
}

void updatePlayerSprite() {
 char i;

 signed char gravityDir = (player.isFaceUp == 1) ? -1 : 1;
 short tileId = getTileId(player.x, player.y - gravityDir);
 char playerSprite = player.y % 2 + 2*(1-player.isFaceUp);
 char combinedTile[lcdCharLength];


 for(i = 0; i < lcdCharLength; i++) {
 combinedTile[i] = playerSprites[playerSprite][i] | tileSprites[tileId][i];
 }


 Lcd_Cmd(charEntryMemory);
 for(i = 0; i < lcdCharLength; i++) { Lcd_Chr_Cp(combinedTile[i]); }
 Lcd_Cmd(_LCD_RETURN_HOME);


 Lcd_Chr((player.y-1)/2 + 1, player.x, 0);
}


void checkAirborne(signed char gravityDir) {
 short below = getTileId(player.x, player.y + gravityDir);
 if(below == undefined) {
 changeGameState(ST_GAMEOVER);
 return;
 }

 player.isAirborne = (below == air) ? 1 : 0;
}


void checkCurTile() {
 short tileId = getTileId(player.y, player.x);
 if(tileId == goal) { changeGameState(ST_GOAL); }
 else if(tileId == spikeU || tileId == spikeD) { changeGameState(ST_GAMEOVER); }
}
