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

#define lcdWidth 20
#define lcdHeight 4


typedef struct Player {
  char x, y;
  char isFaceUp, isAirborne;
} player;


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

// Levels
char levels[2][lcdHeight][lcdWidth] = {
  // Level 1
 {{3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3},
  {6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},

  {3,3,3,3,3,3,3,3,5,5,5,5,3,3,3,3,3,3,3,3},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},

  {0,0,0,0,0,0,0,3,3,3,3,3,3,3,3,3,4,4,3,3},
  {0,3,3,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0},

  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7},
  {3,3,0,0,0,0,3,3,3,3,3,3,4,4,4,3,3,3,3,3}},
  // Level 2
 {{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}},
};

static const char numberTiles = 2;
static const char lcdCharLength = 8;
static const char tiles[numberTiles][lcdCharLength] = {
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
   0b00011111,
   0b00011111,
   0b00011111,
   0b00011111}
};

void updatePlayerChar(char id1, char id2) {
  char combinedTile[lcdCharLength];
  for(i = 0; i < lcdCharLength; i++) {
    combinedTile[i] = tiles[id1][i] | tiles[id2][i];
  }
  Lcd_RS = 0;
  Lcd_Cmd(64);
  Lcd_RS = 1;
  for(i = 0; i < lcdCharLength; i++) { Lcd_Chr_Cp(combinedTile[i]); }
  Lcd_RS = 0;
  Lcd_Cmd(128);
  Lcd_RS = 1;
}

char curLevel = 0;

// Loop variables
int i, j;

void initialize();
void initPIC();
void initLCD();
void loadLevel(char);
void update();


void main() {
  initialize();
  loadLevel(0);
  while(1) { update(); }
}

char getBlock(char x, char y) {
  if(x < 0 || x > lcdWidth || y < 0 || y > lcdHeight) { return -1; }
  return levels[curLevel][y][x];
}

void checkAirborne() {
  char offset = player.isFaceUp ? -1 : 1;
  char below[8] = getBlock(player.x, player.y+offset);
  if(below == Block.air ||
    (below == Block.spikeU && isFaceUp) ||
    (below == Block.spikeD && !isFaceUp)) {
    player.isAirborne = true;
  }
  player.isAirborne = false;
}

void update() {
  /*checkAirborne();
  if(!player.isAirborne) {
    if(leftBtn) {
      if(getBlock(player.x-1, player.y) == Block.air) {
        player.x--;
      }
    }
    else if(rightBtn) {
      if(getBlock(player.x+1, player.y) == Block.air) {
        player.x++;
      }
    }
    else if(gravityBtn) {
      isFaceUp = ~isFaceUp;
    }
  }
  if(isAirborne) { player.y--; }
  //checkCurTile(); // Check for goal, spikes etc.*/

  Lcd_Cmd(_LCD_CLEAR);
  updatePlayerChar(1);
  Lcd_Chr(1, 1);

  delay_ms(100);
}

void initialize() {
  initPIC();
  initLCD();
  initGame();
}

void loadLevel(char levelIndex) {
  for(i = 1; i <= lcdHeight; i++) {
    for(j = 1; j <= lcdWidth; j++) {
      Lcd_Chr(i, j, levels[levelIndex][i][j]);
    }
  }
}

void initGame() {
  player.x = player.y = player.isAirborne = 0;
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

  Lcd_RS = 0;
  Lcd_Cmd(64);
  Lcd_RS = 1;

  for(i = 0; i < numberTiles; i++) {
    for(j = 0; j < lcdCharLength; j++) { Lcd_Chr_Cp(tiles[i][j]); }
  }

  // Player, face-up_upper
  Lcd_Chr_Cp(0b00001010);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00010001);
  Lcd_Chr_Cp(0b00001110);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);

  // Player, face-up_lower
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00001010);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00010001);
  Lcd_Chr_Cp(0b00001110);

  // Player, face-down_upper
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00001110);
  Lcd_Chr_Cp(0b00010001);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00001010);

  // Player, face-down_lower
  Lcd_Chr_Cp(0b00001110);
  Lcd_Chr_Cp(0b00010001);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00001010);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);

  // Block
  /*Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00011111);*/

  // Half block, upper
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);

  // Half block, lower
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00011111);

  // Spike, upper
  Lcd_Chr_Cp(0b00011111);
  Lcd_Chr_Cp(0b00001110);
  Lcd_Chr_Cp(0b00000100);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);

  // Spike, lower
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000000);
  Lcd_Chr_Cp(0b00000100);
  Lcd_Chr_Cp(0b00001110);
  Lcd_Chr_Cp(0b00011111);

  Lcd_RS = 0;
  Lcd_Cmd(128);
  Lcd_RS = 1;
}
