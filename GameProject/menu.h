/*
  menu.h - used for drawing and updating the ST_Menu GameState

  Authors: Anton Håkansson & Jacob Eriksson
  Date: 2017-05-03
*/

#ifndef MENU_H_
#define MENU_H_

/*
    Declarations
*/

// User inputs
sbit selectBtn at PORTC.B5;
sbit upBtn at PORTC.B6;
sbit downBtn at PORTC.B7;

// Holds the currently highlighted level acoording to the index of levels in levels.h
extern char menuSelection;

/*
    Functions
*/

// Clears LCD and prints menu state barebones
//  Produces:
//      |     Level Selection
//      |
//      |
//      |
void loadMenu();

// Prints selectable levels with arguemnt start indicating the level to appear
// at the top as an index of levels array defined in levels.h
//    May produce, assuming nothing previously displayed on LCD and start = 2.
//        |                        |
//        |         Level 3        |
//        |         Level 4        |
//        |         Level 5        |
void printSelectableLevels(char start);

// Polls user input, and prints arrow highlighting current selection
//  Also updates displayed levels with printSelectableLevels calls
//  if the users selection goes beyond LCD bounds.
void updateMenu();

#endif
