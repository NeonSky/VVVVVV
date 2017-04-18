// LCD display configuration
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

// Player Inputs
sbit gravityBtn at PORTC.B5;
sbit leftBtn at PORTC.B6;
sbit rightBtn at PORTC.B7;

static const char levelCount = 2;
static const char lcdWidth = 20;
static const char lcdHeight = 4;

struct Player {
  char x;
  char y;
  char isAirborne;
  short isFaceUp;
};
struct Player player = {0, 0, 0, 1};

enum Block {
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

static const char levels[levelCount][lcdHeight*2][lcdWidth] = {
  // Level 1
 {{5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5},
  {6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},

  {3,3,3,3,3,3,3,3,5,5,5,5,3,3,3,3,3,3,3,3},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},

  {0,0,0,0,0,0,0,3,3,3,3,3,3,3,3,3,4,4,3,3},
  {0,3,3,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0},

  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7},
  {3,3,0,0,0,0,3,3,3,3,3,3,4,4,4,3,3,3,3,3}},

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

static const char lcdCharLength = 8;
static const char tiles[][lcdCharLength] = {
  // Air
  {0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000},

  // Player, face-up_upper
  {0b00001010,
   0b00000000,
   0b00010001,
   0b00001110,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00000000},

  // Player, face-up_lower
  {0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00001010,
   0b00000000,
   0b00010001,
   0b00001110},

  // Player, face-down_upper
  {0b00000000,
   0b00000000,
   0b00000000,
   0b00000000,
   0b00001110,
   0b00010001,
   0b00000000,
   0b00001010},

  // Player, face-down_lower
  {0b00001110,
   0b00010001,
   0b00000000,
   0b00001010,
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
   0b00011111}

};
static const char tileCount = sizeof(tiles)/sizeof(tiles[0]);

char curLevel = 0;

// Loop variables
int i, j;

void initialize();
void initPIC();
void initLCD();
void initGame();
void loadLevel(char);
void update();
void combineTiles(char, char);
char getBlockId(char, char);
void checkAirborne();


void main() {
  initialize();
  loadLevel(0);
  while(1) { update(); }
}

void initialize() {
  initPIC();
  initLCD();
  initGame();
}

void initGame() {
  player.isAirborne = 0;
  player.isFaceUp = 1;
}

void initPIC() {
  OSCCON = 0b01110111; // 8 MHz
  ANSEL = 0b00000000;
  ANSELH = 0b00000000;

  TRISA = 0b00000000;
  TRISB = 0b00000000;
  TRISC = 0b00000000;
  PORTA = 0b00000000;
  PORTB = 0b00000000;
  PORTC = 0b00000000;
}

void initLCD() {
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Cmd(_LCD_CURSOR_OFF);

  // Load custom characters to memory
  Lcd_RS = 0;
  Lcd_Cmd(64+lcdCharLength);
  Lcd_RS = 1;

  for(i = 0; i < tileCount; i++) {
    for(j = 0; j < lcdCharLength; j++) {
      Lcd_Chr_Cp(tiles[i][j]);
    }
  }

  Lcd_RS = 0;
  Lcd_Cmd(128);
  Lcd_RS = 1;
}

void loadLevel(char levelIndex) {
  curLevel = levelIndex;

  for(i = 0; i < lcdHeight; i++) {
    for(j = 0; j < lcdWidth; j++) {
      combineTiles(levels[curLevel][2*i][j], levels[curLevel][2*i+1][j]);
      Lcd_Chr(i+1, j+1, 0);
    }
  }
}

void combineTiles(char id1, char id2) {
  char it;
  char combinedTile[lcdCharLength];
  for(it = 0; it < lcdCharLength; it++) {
    combinedTile[it] = tiles[id1][it] | tiles[id2][it];
  }
  Lcd_Cmd(64);
  for(it = 0; it < lcdCharLength; it++) { Lcd_Chr_Cp(combinedTile[it]); }
  Lcd_Cmd(_LCD_RETURN_HOME);
}

char getBlockId(char x, char y) {
  if(x < 0 || x > lcdWidth || y < 0 || y > lcdHeight) { return -1; }
  return levels[curLevel][y][x];
}

void checkAirborne() {
  short offset;
  char below;
  offset = player.isFaceUp == 1 ? -1 : 1;
  below = getBlockId(player.x, player.y+offset);
  if(below == air ||
    (below == spikeU && player.isFaceUp == 1) ||
    (below == spikeD && player.isFaceUp == 0)) {
    player.isAirborne = 1;
  }
  player.isAirborne = 0;
}

void update() {
  /*checkAirborne();
  if(!player.isAirborne) {
    if(leftBtn) {
      if(getBlock(player.x-1, player.y) == air) {
        player.x--;
      }
    }
    else if(rightBtn) {
      if(getBlock(player.x+1, player.y) == air) {
        player.x++;
      }
    }
    else if(gravityBtn) {
      isFaceUp = ~isFaceUp;
    }
  }
  if(isAirborne) { player.y--; }
  //checkCurTile(); // Check for goal, spikes etc.    */

  /*if(player.y % 2 == 0) {
    combineTiles(0, levels[curLevel][2*player.y+1][player.x]);
  } else {
    combineTiles(1, levels[curLevel][2*player.y][player.x]);
  */
  delay_ms(50);
}
