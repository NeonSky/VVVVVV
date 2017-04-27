#include "lcd.h"

#include "levels.h"

void initLCD() {
  char i, j;

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
