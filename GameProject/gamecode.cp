#line 1 "Z:/home/batman/git/VVVVVV/GameProject/gamecode.c"
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
#line 1 "z:/home/batman/git/vvvvvv/gameproject/menu.h"
#line 7 "z:/home/batman/git/vvvvvv/gameproject/menu.h"
void loadMenu();
#line 1 "z:/home/batman/git/vvvvvv/gameproject/levels.h"
#line 1 "z:/home/batman/git/vvvvvv/gameproject/lcd.h"
#line 10 "z:/home/batman/git/vvvvvv/gameproject/levels.h"
void loadLevel(char levelIndex);
char getTileId(char x, char y);
#line 18 "z:/home/batman/git/vvvvvv/gameproject/levels.h"
static char curLevel = 0;
static const char levels[][lcdHeight*2][lcdWidth] = {

 {{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
 {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},

 {1,1,1,1,1,1,1,1,3,3,3,3,1,1,1,1,1,1,1,0},
 {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},

 {0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,3,3,1,1},
 {0,2,2,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0},

 {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
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
 playerU = 1,
 playerD = 2,
 solid = 3,
 spikeU = 4,
 spikeD = 5,
 start = 6,
 goal = 7
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
 0b00011111}
};
static const char tileCount = sizeof(tileSprites)/sizeof(tileSprites[0]);
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
void initPlayer();
void movePlayer();
void updatePlayerSprite();
void checkAirborne(signed char gravityDir);
void clampPlayerPos();
#line 36 "z:/home/batman/git/vvvvvv/gameproject/player.h"
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
#line 6 "Z:/home/batman/git/VVVVVV/GameProject/gamecode.c"
typedef enum GameState {
 ST_MENU,
 ST_PAUSE,
 ST_INGAME
} GameState;
GameState gameState = ST_MENU;

void initialize();
void initPIC();
void changeGameState(GameState newState);
void update();
void goalReached();


static const char updateInterval = 50;

void main() {
 initialize();

 changeGameState(ST_MENU);
 while(1) { update(); }
}

void initialize() {
 initPIC();
 initLCD();
}

void initPIC() {
 OSCCON = 0b01110111;
 ANSEL = 0b00000000;
 ANSELH = 0b00000000;

 TRISA = 0b00000000;
 TRISB = 0b00000000;
 TRISC = 0b00000000;
 PORTA = 0b00000000;
 PORTB = 0b00000000;
 PORTC = 0b00000000;
}

void changeGameState(GameState newState) {
 if (newState == ST_MENU) {
 loadMenu();
 }
 if (gameState == ST_MENU && newState == ST_INGAME) {

 initPlayer();
 }
 gameState = newState;
}

void update() {
 switch (gameState) {
 case ST_MENU:
 break;
 case ST_INGAME:
 movePlayer();
 if(getTileId(player.y+1, player.x+1) == goal) { goalReached(); }
 break;
 case ST_PAUSE:
 break;
 }
 delay_ms(updateInterval);
}

void goalReached() {

}
