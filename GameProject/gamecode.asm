
_updatePlayerChar:

;gamecode.c,97 :: 		void updatePlayerChar(char id1, char id2) {
;gamecode.c,99 :: 		for(i = 0; i < lcdCharLength; i++) {
	CLRF       _i+0
	CLRF       _i+1
L_updatePlayerChar0:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updatePlayerChar38
	MOVLW      8
	SUBWF      _i+0, 0
L__updatePlayerChar38:
	BTFSC      STATUS+0, 0
	GOTO       L_updatePlayerChar1
;gamecode.c,100 :: 		combinedTile[i] = tiles[id1][i] | tiles[id2][i];
	MOVF       _i+0, 0
	ADDLW      updatePlayerChar_combinedTile_L0+0
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R2+0
	MOVF       FARG_updatePlayerChar_id1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R2+0, 0
L__updatePlayerChar39:
	BTFSC      STATUS+0, 2
	GOTO       L__updatePlayerChar40
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__updatePlayerChar39
L__updatePlayerChar40:
	MOVLW      gamecode_tiles+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(gamecode_tiles+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       _i+0, 0
	ADDWF      R0+0, 1
	MOVF       _i+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R3+0
	MOVLW      3
	MOVWF      R2+0
	MOVF       FARG_updatePlayerChar_id2+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R2+0, 0
L__updatePlayerChar41:
	BTFSC      STATUS+0, 2
	GOTO       L__updatePlayerChar42
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__updatePlayerChar41
L__updatePlayerChar42:
	MOVLW      gamecode_tiles+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(gamecode_tiles+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       _i+0, 0
	ADDWF      R0+0, 1
	MOVF       _i+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R3+0, 0
	IORWF      R0+0, 1
	MOVF       R4+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;gamecode.c,99 :: 		for(i = 0; i < lcdCharLength; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;gamecode.c,101 :: 		}
	GOTO       L_updatePlayerChar0
L_updatePlayerChar1:
;gamecode.c,102 :: 		Lcd_RS = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,103 :: 		Lcd_Cmd(64);
	MOVLW      64
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,104 :: 		Lcd_RS = 1;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,105 :: 		for(i = 0; i < lcdCharLength; i++) { Lcd_Chr_Cp(combinedTile[i]); }
	CLRF       _i+0
	CLRF       _i+1
L_updatePlayerChar3:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updatePlayerChar43
	MOVLW      8
	SUBWF      _i+0, 0
L__updatePlayerChar43:
	BTFSC      STATUS+0, 0
	GOTO       L_updatePlayerChar4
	MOVF       _i+0, 0
	ADDLW      updatePlayerChar_combinedTile_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
	GOTO       L_updatePlayerChar3
L_updatePlayerChar4:
;gamecode.c,106 :: 		Lcd_RS = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,107 :: 		Lcd_Cmd(128);
	MOVLW      128
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,108 :: 		Lcd_RS = 1;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,109 :: 		}
L_end_updatePlayerChar:
	RETURN
; end of _updatePlayerChar

_main:

;gamecode.c,111 :: 		void main() {
;gamecode.c,112 :: 		initialize();
	CALL       _initialize+0
;gamecode.c,113 :: 		loadLevel(0);
	CLRF       FARG_loadLevel+0
	CALL       _loadLevel+0
;gamecode.c,114 :: 		while(1) { update(); }
L_main6:
	CALL       _update+0
	GOTO       L_main6
;gamecode.c,115 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_getBlockId:

;gamecode.c,117 :: 		char getBlockId(char x, char y) {
;gamecode.c,118 :: 		if(x < 0 || x > lcdWidth || y < 0 || y > lcdHeight) { return -1; }
	MOVLW      0
	SUBWF      FARG_getBlockId_x+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__getBlockId33
	MOVF       FARG_getBlockId_x+0, 0
	SUBLW      20
	BTFSS      STATUS+0, 0
	GOTO       L__getBlockId33
	MOVLW      0
	SUBWF      FARG_getBlockId_y+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__getBlockId33
	MOVF       FARG_getBlockId_y+0, 0
	SUBLW      4
	BTFSS      STATUS+0, 0
	GOTO       L__getBlockId33
	GOTO       L_getBlockId10
L__getBlockId33:
	MOVLW      255
	MOVWF      R0+0
	GOTO       L_end_getBlockId
L_getBlockId10:
;gamecode.c,119 :: 		return levels[curLevel][y][x];
	MOVLW      160
	MOVWF      R0+0
	MOVF       _curLevel+0, 0
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	ADDLW      _levels+0
	MOVWF      FLOC__getBlockId+0
	MOVLW      20
	MOVWF      R0+0
	MOVF       FARG_getBlockId_y+0, 0
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       FLOC__getBlockId+0, 0
	ADDWF      R0+0, 1
	MOVF       FARG_getBlockId_x+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
;gamecode.c,120 :: 		}
L_end_getBlockId:
	RETURN
; end of _getBlockId

_checkAirborne:

;gamecode.c,122 :: 		void checkAirborne() {
;gamecode.c,123 :: 		short offset = player.isFaceUp ? -1 : 1;
	MOVF       _player+2, 0
	BTFSC      STATUS+0, 2
	GOTO       L_checkAirborne11
	MOVLW      255
	MOVWF      ?FLOC___checkAirborneT41+0
	GOTO       L_checkAirborne12
L_checkAirborne11:
	MOVLW      1
	MOVWF      ?FLOC___checkAirborneT41+0
L_checkAirborne12:
;gamecode.c,124 :: 		char below = getBlockId(player.x, player.y+offset);
	MOVF       _player+0, 0
	MOVWF      FARG_getBlockId_x+0
	MOVF       ?FLOC___checkAirborneT41+0, 0
	ADDWF      _player+1, 0
	MOVWF      FARG_getBlockId_y+0
	CALL       _getBlockId+0
	MOVF       R0+0, 0
	MOVWF      checkAirborne_below_L0+0
;gamecode.c,126 :: 		(below == spikeU && player.isFaceUp == 1) ||
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L__checkAirborne34
	MOVF       checkAirborne_below_L0+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L__checkAirborne36
	MOVF       _player+2, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkAirborne36
	GOTO       L__checkAirborne34
L__checkAirborne36:
;gamecode.c,127 :: 		(below == spikeD && player.isFaceUp == 0)) {
	MOVF       checkAirborne_below_L0+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L__checkAirborne35
	MOVF       _player+2, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkAirborne35
	GOTO       L__checkAirborne34
L__checkAirborne35:
	GOTO       L_checkAirborne19
L__checkAirborne34:
;gamecode.c,129 :: 		}
L_checkAirborne19:
;gamecode.c,130 :: 		player.isAirborne = 0;
	CLRF       _player+3
;gamecode.c,131 :: 		}
L_end_checkAirborne:
	RETURN
; end of _checkAirborne

_update:

;gamecode.c,133 :: 		void update() {
;gamecode.c,153 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,154 :: 		updatePlayerChar(0, 1);
	CLRF       FARG_updatePlayerChar_id1+0
	MOVLW      1
	MOVWF      FARG_updatePlayerChar_id2+0
	CALL       _updatePlayerChar+0
;gamecode.c,155 :: 		Lcd_Chr(1, 1, 0);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_column+0
	CLRF       FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;gamecode.c,157 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_update20:
	DECFSZ     R13+0, 1
	GOTO       L_update20
	DECFSZ     R12+0, 1
	GOTO       L_update20
	DECFSZ     R11+0, 1
	GOTO       L_update20
	NOP
;gamecode.c,158 :: 		}
L_end_update:
	RETURN
; end of _update

_initialize:

;gamecode.c,160 :: 		void initialize() {
;gamecode.c,161 :: 		initPIC();
	CALL       _initPIC+0
;gamecode.c,162 :: 		initLCD();
	CALL       _initLCD+0
;gamecode.c,164 :: 		}
L_end_initialize:
	RETURN
; end of _initialize

_loadLevel:

;gamecode.c,166 :: 		void loadLevel(char levelIndex) {
;gamecode.c,167 :: 		for(i = 1; i <= lcdHeight; i++) {
	MOVLW      1
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_loadLevel21:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__loadLevel50
	MOVF       _i+0, 0
	SUBLW      4
L__loadLevel50:
	BTFSS      STATUS+0, 0
	GOTO       L_loadLevel22
;gamecode.c,168 :: 		for(j = 1; j <= lcdWidth; j++) {
	MOVLW      1
	MOVWF      _j+0
	MOVLW      0
	MOVWF      _j+1
L_loadLevel24:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _j+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__loadLevel51
	MOVF       _j+0, 0
	SUBLW      20
L__loadLevel51:
	BTFSS      STATUS+0, 0
	GOTO       L_loadLevel25
;gamecode.c,169 :: 		Lcd_Chr(i, j, levels[levelIndex][i][j]);
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _j+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      160
	MOVWF      R0+0
	MOVF       FARG_loadLevel_levelIndex+0, 0
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	ADDLW      _levels+0
	MOVWF      FLOC__loadLevel+0
	MOVLW      20
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       _i+0, 0
	MOVWF      R4+0
	MOVF       _i+1, 0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       FLOC__loadLevel+0, 0
	ADDWF      R0+0, 1
	MOVF       _j+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;gamecode.c,168 :: 		for(j = 1; j <= lcdWidth; j++) {
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;gamecode.c,170 :: 		}
	GOTO       L_loadLevel24
L_loadLevel25:
;gamecode.c,167 :: 		for(i = 1; i <= lcdHeight; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;gamecode.c,171 :: 		}
	GOTO       L_loadLevel21
L_loadLevel22:
;gamecode.c,172 :: 		}
L_end_loadLevel:
	RETURN
; end of _loadLevel

_initPIC:

;gamecode.c,180 :: 		void initPIC() {
;gamecode.c,181 :: 		OSCCON = 0b01110111; // 8 MHz
	MOVLW      119
	MOVWF      OSCCON+0
;gamecode.c,182 :: 		ANSEL = 0b00000000;
	CLRF       ANSEL+0
;gamecode.c,183 :: 		ANSELH = 0b00000000;
	CLRF       ANSELH+0
;gamecode.c,185 :: 		TRISA = 0b00000000;
	CLRF       TRISA+0
;gamecode.c,186 :: 		TRISB = 0b00000000;
	CLRF       TRISB+0
;gamecode.c,187 :: 		TRISC = 0b00000000;
	CLRF       TRISC+0
;gamecode.c,188 :: 		PORTA = 0b00000000;
	CLRF       PORTA+0
;gamecode.c,189 :: 		PORTB = 0b00000000;
	CLRF       PORTB+0
;gamecode.c,190 :: 		PORTC = 0b00000000;
	CLRF       PORTC+0
;gamecode.c,191 :: 		}
L_end_initPIC:
	RETURN
; end of _initPIC

_initLCD:

;gamecode.c,193 :: 		void initLCD() {
;gamecode.c,194 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;gamecode.c,195 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,196 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,198 :: 		Lcd_RS = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,199 :: 		Lcd_Cmd(64);
	MOVLW      64
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,200 :: 		Lcd_RS = 1;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,202 :: 		for(i = 0; i < numberTiles; i++) {
	CLRF       _i+0
	CLRF       _i+1
L_initLCD27:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__initLCD54
	MOVLW      2
	SUBWF      _i+0, 0
L__initLCD54:
	BTFSC      STATUS+0, 0
	GOTO       L_initLCD28
;gamecode.c,203 :: 		for(j = 0; j < lcdCharLength; j++) { Lcd_Chr_Cp(tiles[i][j]); }
	CLRF       _j+0
	CLRF       _j+1
L_initLCD30:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__initLCD55
	MOVLW      8
	SUBWF      _j+0, 0
L__initLCD55:
	BTFSC      STATUS+0, 0
	GOTO       L_initLCD31
	MOVLW      3
	MOVWF      R2+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__initLCD56:
	BTFSC      STATUS+0, 2
	GOTO       L__initLCD57
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__initLCD56
L__initLCD57:
	MOVLW      gamecode_tiles+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(gamecode_tiles+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       _j+0, 0
	ADDWF      R0+0, 1
	MOVF       _j+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
	GOTO       L_initLCD30
L_initLCD31:
;gamecode.c,202 :: 		for(i = 0; i < numberTiles; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;gamecode.c,204 :: 		}
	GOTO       L_initLCD27
L_initLCD28:
;gamecode.c,207 :: 		Lcd_Chr_Cp(0b00001010);
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,208 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,209 :: 		Lcd_Chr_Cp(0b00010001);
	MOVLW      17
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,210 :: 		Lcd_Chr_Cp(0b00001110);
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,211 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,212 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,213 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,214 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,217 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,218 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,219 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,220 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,221 :: 		Lcd_Chr_Cp(0b00001010);
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,222 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,223 :: 		Lcd_Chr_Cp(0b00010001);
	MOVLW      17
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,224 :: 		Lcd_Chr_Cp(0b00001110);
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,227 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,228 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,229 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,230 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,231 :: 		Lcd_Chr_Cp(0b00001110);
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,232 :: 		Lcd_Chr_Cp(0b00010001);
	MOVLW      17
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,233 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,234 :: 		Lcd_Chr_Cp(0b00001010);
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,237 :: 		Lcd_Chr_Cp(0b00001110);
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,238 :: 		Lcd_Chr_Cp(0b00010001);
	MOVLW      17
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,239 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,240 :: 		Lcd_Chr_Cp(0b00001010);
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,241 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,242 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,243 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,244 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,257 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,258 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,259 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,260 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,261 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,262 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,263 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,264 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,267 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,268 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,269 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,270 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,271 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,272 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,273 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,274 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,277 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,278 :: 		Lcd_Chr_Cp(0b00001110);
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,279 :: 		Lcd_Chr_Cp(0b00000100);
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,280 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,281 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,282 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,283 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,284 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,287 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,288 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,289 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,290 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,291 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,292 :: 		Lcd_Chr_Cp(0b00000100);
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,293 :: 		Lcd_Chr_Cp(0b00001110);
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,294 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,296 :: 		Lcd_RS = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,297 :: 		Lcd_Cmd(128);
	MOVLW      128
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,298 :: 		Lcd_RS = 1;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,299 :: 		}
L_end_initLCD:
	RETURN
; end of _initLCD
