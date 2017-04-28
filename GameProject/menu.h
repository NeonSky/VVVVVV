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

// Initializes and prints menu state barebones
void loadMenu();

// Prints selectable levels - with arrow pointing to currently selected one
void printSelectableLevels(char start);

// Polls user input, and prints selected menu
void updateMenu();

#endif
