#ifndef LCD_H_
#define LCD_H_

/*
    Declarations
*/

// LCD display configuration
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;


/*
    Functions
*/
void initLCD();


/*
    Constants
*/
static const char lcdWidth = 20; // Width of LCD, measured in cells
static const char lcdHeight = 4; // Height of LCD, measured in cells
static const char lcdCharLength = 8; // Bytes to store a custom char
static const char charEntryMemory = 64; // Memory to overwrite for custom chars

#endif
