#line 1 "C:/Users/Deltagare/Documents/GitHub/VVVVVV/GameProject/gamecode.c"

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

void initialize();
void initPIC();
void initLCD();
void update();


void main() {
 initialize();
 while(1) { update(); }
}

void update() {
}

int i, j;
void initialize() {
 initPIC();
 initLCD();

 for(i = 1; i <= 4; i++) {
 for(j = 1; j <= 20; j++) {
 Lcd_Chr(i, j, j%4);
 }
 }
}

void initPIC() {
 OSCCON = 0b01110111;
 ANSEL = 0b00000000;
 ANSELH = 0b00000000;

 TRISA = 0b00000000;
 TRISB = 0b00000000;
 TRISC = 0b00000000;
 PORTA = 0b00000000;
 PORTB = 0b00000000;
 PORTC = 0b00000000;
}

void initLCD() {
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 LCD_RS = 0;
 LCD_Cmd(64);
 LCD_RS = 1;


 LCD_Chr_Cp(0b00001010);
 LCD_Chr_Cp(0b00010001);
 LCD_Chr_Cp(0b00011111);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);


 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00011111);
 LCD_Chr_Cp(0b00010001);
 LCD_Chr_Cp(0b00001010);


 LCD_Chr_Cp(0b00011111);
 LCD_Chr_Cp(0b00011111);
 LCD_Chr_Cp(0b00011111);
 LCD_Chr_Cp(0b00011111);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);


 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00000000);
 LCD_Chr_Cp(0b00011111);
 LCD_Chr_Cp(0b00011111);
 LCD_Chr_Cp(0b00011111);
 LCD_Chr_Cp(0b00011111);

 LCD_RS = 0;
 LCD_Cmd(128);
 LCD_RS = 1;
}
