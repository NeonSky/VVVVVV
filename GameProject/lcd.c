#include "lcd.h"
#include "levels.h"

void initLCD() {
  char i, j;

  // Setup LCD display
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Cmd(_LCD_CURSOR_OFF);

  // Load custom characters to display's CGRAM
  Lcd_Cmd(charEntryMemory + lcdCharLength);
  for (i = 0; i < tileCount; i++) {
    for (j = 0; j < lcdCharLength; j++) {
      Lcd_Chr_Cp(tileSprites[i][j]);
    }
  }

  // Reposition cursor
  Lcd_Cmd(_LCD_RETURN_HOME);
}
