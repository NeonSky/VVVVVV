void charachters() {
  LCD_RS=0;
  LCD_Cmd(64);
  LCD_RS=1;

  // Smiley logisk gravitation
  LCD_Chr_Cp(0b00001010);
  LCD_Chr_Cp(0b00010001);
  LCD_Chr_Cp(0b00011111);
  LCD_Chr_Cp(0b00000000);
  LCD_Chr_Cp(0b00000000);
  LCD_Chr_Cp(0b00000000);
  LCD_Chr_Cp(0b00000000);
  LCD_Chr_Cp(0b00000000);

  // Smiley ologisk gravitation
  LCD_Chr_Cp(0b00000000);
  LCD_Chr_Cp(0b00000000);
  LCD_Chr_Cp(0b00000000);
  LCD_Chr_Cp(0b00000000);
  LCD_Chr_Cp(0b00000000);
  LCD_Chr_Cp(0b00011111);
  LCD_Chr_Cp(0b00010001);
  LCD_Chr_Cp(0b00001010);

  // Half blocks, upper
  LCD_Chr_Cp(0b00011111);
  LCD_Chr_Cp(0b00011111);
  LCD_Chr_Cp(0b00011111);
  LCD_Chr_Cp(0b00011111);
  LCD_Chr_Cp(0b00000000);
  LCD_Chr_Cp(0b00000000);
  LCD_Chr_Cp(0b00000000);
  LCD_Chr_Cp(0b00000000);

  // Half blocks, lower
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
