#include "lcd.h"

#include "levels.h"

void initLCD() {
  char i, j;

  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Cmd(_LCD_CURSOR_OFF);

  // Load custom characters to memory
  Lcd_Cmd(charEntryMemory + lcdCharLength);
  for(i = 0; i < tileCount; i++) {
    for(j = 0; j < lcdCharLength; j++) {
      Lcd_Chr_Cp(tileSprites[i][j]);
    }
  }
  Lcd_Cmd(_LCD_RETURN_HOME);
}
