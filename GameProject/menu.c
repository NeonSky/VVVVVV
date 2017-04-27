#include "menu.h"
#include "lcd.h"
#include "levels.h"

char menuSelection = 0;
char prevMenuSelection = 0;

void loadMenu () {
  // Print Menu Title
  char i;
  char menuTitle[] = "Menu";
  char menuTitleLength = sizeof(menuTitle)/sizeof(menuTitle[0]);
  char menuTitlePos = lcdWidth/2-menuTitleLength/2;

  Lcd_Cmd(_LCD_CLEAR);

  //Lcd_Out (1, menuTitlePos, menuTitle);
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
    // Print level
    Lcd_Chr ( 2+i, levelsTextIndent, baseString[0]);
    for (j = 1; j < numChars-1; j++)
      Lcd_Chr_Cp (baseString[j]);

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
