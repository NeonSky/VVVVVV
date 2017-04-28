#include "menu.h"
#include "lcd.h"
#include "levels.h"

char __internal_i;

#define __PRINT(Y, X, STRING, LENGTH)                                   \
Lcd_Chr ( (Y), (X), (STRING)[0]);                                       \
for (__internal_i = 1; __internal_i < (LENGTH)-1; __internal_i++)       \
  Lcd_Chr_Cp ((STRING)[__internal_i]);                                  \

char menuSelection = 0;
char prevMenuSelection = 0;

void loadMenu () {
  // Print Menu Title
  char i;
  char menuTitle[] = "Menu";
  char menuTitleLength = sizeof(menuTitle)/sizeof(menuTitle[0]);
  char menuTitlePos = lcdWidth/2-menuTitleLength/2;

  Lcd_Cmd(_LCD_CLEAR);
  __PRINT(1, menuTitlePos, menuTitle, menuTitleLength);
}

void printSelectableLevels(char start) {
  static const char levelsTextIndent = 4;
  char i;
  char levelsToPrint = min(levelCount, 3);
  char baseString[] = "Level ";
  char numChars = sizeof(baseString)/sizeof(baseString[0]);

  for (i = 0; i < levelsToPrint; i++) {
    __PRINT(2+i, levelsTextIndent, baseString, numChars)
    Lcd_Chr_Cp (start+i+1+'0');
  }
}

void updateMenu() {
  static const char selectionIndent = 2;
  char shouldUpdate = prevMenuSelection != menuSelection;

  // Clear current arrow
  if(shouldUpdate) Lcd_Out (2+prevMenuSelection%3, selectionIndent, "  ");

  // Poll user input
  // TODO: förhindra kontaktstudsar
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

  // TODO: update printed levels if selection reaches above or below screen
  /* something like

  if (shouldUpdate && menuSelection%3 == 0) {
    printSelectableLevels(menuSelection);
  }
  */

  // Print selection arrow
  if(shouldUpdate) Lcd_Out (2+menuSelection%3, selectionIndent, "->");
}
