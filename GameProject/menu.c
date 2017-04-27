#include "menu.h"
#include "lcd.h"
#include "levels.h"

char menuSelection = 0;
char prevMenuSelection = 0;

void loadMenu () {

  // Print Menu Title
  char menuTitle[] = "Menu";
  char menuTitleLength = sizeof(menuTitle)/sizeof(menuTitle[0]);
  char menuTitlePos = lcdWidth/2-menuTitleLength/2;
  Lcd_Out (1, menuTitlePos, menuTitle);

  // Print levels 0-3
  printSelectableLevels (0);
}

void printSelectableLevels(char start) {
  static const char levelsTextIndent = 4;
  char i;
  char levelsToPrint = min(levelCount, 3);

  for (i = 0; i < levelsToPrint; i++) {
    // Print level
    Lcd_Out ( 2+i, levelsTextIndent, "Level ");
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
