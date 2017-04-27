#ifndef MENU_H_
#define MENU_H_

/*
    Declarations
*/

// User inputs
sbit selectBtn at PORTC.B5;
sbit upBtn at PORTC.B6;
sbit downBtn at PORTC.B7;

extern char menuSelection;
extern char prevMenuSelection;

/*
    Functions
*/
void loadMenu();
void updateMenu();
void printSelectableLevels(char start);

#endif
