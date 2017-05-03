#include "menu.h"
#include "lcd.h"
#include "levels.h"

/*
  Low call stack impact implementation of MikroC's built in function LCD_OUT
    workaround of out of call stack memory error.
*/
char __internal_i;
#define __PRINT(Y, X, STRING, LENGTH)                                          \
  Lcd_Chr((Y), (X), (STRING)[0]);                                              \
  for (__internal_i = 1; __internal_i < (LENGTH)-1; __internal_i++)            \
    Lcd_Chr_Cp((STRING)[__internal_i]);

char menuSelection = 0;

void loadMenu() {
  // Print Menu Title
  char i;
  const char menuTitle[] = "Level Select";
  const char menuTitleLength = sizeof(menuTitle) / sizeof(menuTitle[0]);
  // holds title position to approximately position text at the center of LCD
  char menuTitlePos = lcdWidth / 2 - menuTitleLength / 2 + 1;

  // Clear LCD screen before rendering title
  Lcd_Cmd(_LCD_CLEAR);
  __PRINT(1, menuTitlePos, menuTitle, menuTitleLength);
}

void printSelectableLevels(char start) {
  static const char levelsTextIndent = 7; // Describes indentation left of selectable levels
  char i;
  char levelsToPrint = min(levelCount, 3);
  char baseString[] = "Level ";
  char numChars = sizeof(baseString) / sizeof(baseString[0]);

  for (i = 0; i < levelsToPrint; i++) {
    __PRINT(2 + i, levelsTextIndent, baseString, numChars)
    Lcd_Chr_Cp(start + i + 1 + '0');
  }
}

void updateMenu() {
  static const char selectionIndent = 2;

  // Clear current arrow
  Lcd_Out(2 + menuSelection % 3, selectionIndent, "  ");

  // Poll user input
  if (selectBtn) {
    loadLevel(menuSelection);
    return;
  }
  if (upBtn) {
    if (menuSelection <= 0)
      menuSelection = levelCount - 1;
    else
      --menuSelection;

    // Delay to combat contact bounces
    delay_ms(150);
  }
  else if (downBtn) {
    if (menuSelection >= levelCount - 1)
      menuSelection = 0;
    else
      ++menuSelection;

    // Delay to combat contact bounces
    delay_ms(150);
  }

  // TODO: update printed levels if selection reaches above or below screen
  /* something like

  if (shouldUpdate && menuSelection%3 == 0) {
    printSelectableLevels(menuSelection);
  }
  */

  // Print selection arrow
  Lcd_Out(2 + menuSelection % 3, selectionIndent, "->");
}
