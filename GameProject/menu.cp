#line 1 "Z:/home/batman/git/VVVVVV/GameProject/menu.c"
#line 1 "z:/home/batman/git/vvvvvv/gameproject/menu.h"
#line 9 "z:/home/batman/git/vvvvvv/gameproject/menu.h"
sbit selectBtn at PORTC.B5;
sbit upBtn at PORTC.B6;
sbit downBtn at PORTC.B7;

extern char menuSelection;
extern char prevMenuSelection;
#line 19 "z:/home/batman/git/vvvvvv/gameproject/menu.h"
void loadMenu();
void updateMenu();
void printSelectableLevels(char start);
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
#line 5 "Z:/home/batman/git/VVVVVV/GameProject/menu.c"
char menuSelection = 0;
char prevMenuSelection = 0;

void loadMenu () {

 char i;
 char menuTitle[] = "Menu";
 char menuTitleLength = sizeof(menuTitle)/sizeof(menuTitle[0]);
 char menuTitlePos = lcdWidth/2-menuTitleLength/2;

 Lcd_Cmd(_LCD_CLEAR);


 Lcd_Chr(1, menuTitlePos, menuTitle[0]);
 for (i = 1; i < menuTitleLength-1; i++) {
 Lcd_Chr_Cp(menuTitle[i]);
 }
}

void printSelectableLevels(char start) {
 static const char levelsTextIndent = 4;
 char i, j;
 char levelsToPrint = min(levelCount, 3);
 char baseString[] = "Level ";
 char numChars = sizeof(baseString)/sizeof(baseString[0]);

 for (i = 0; i < levelsToPrint; i++) {

 Lcd_Chr ( 2+i, levelsTextIndent, baseString[0]);
 for (j = 1; j < numChars-1; j++)
 Lcd_Chr_Cp (baseString[j]);

 Lcd_Chr_Cp (start+i+1+'0');
 }
}

void updateMenu() {
 static const char selectionIndent = 2;
 char shouldUpdate = prevMenuSelection != menuSelection;


 if(shouldUpdate) Lcd_Out (2+prevMenuSelection%3, selectionIndent, "  ");



 if (selectBtn) {
 loadLevel(menuSelection);
 }

 prevMenuSelection = menuSelection;
 if (upBtn) {
 menuSelection = (menuSelection-1)%levelCount;
 }
 if (downBtn) {
 menuSelection = (menuSelection+1)%levelCount;
 }
#line 71 "Z:/home/batman/git/VVVVVV/GameProject/menu.c"
 if(shouldUpdate) Lcd_Out (2+menuSelection%3, selectionIndent, "->");
}
