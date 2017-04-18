
_main:

;gamecode.c,174 :: 		void main() {
;gamecode.c,175 :: 		initialize();
	CALL       _initialize+0
;gamecode.c,176 :: 		loadLevel(0);
	CLRF       FARG_loadLevel+0
	CALL       _loadLevel+0
;gamecode.c,177 :: 		while(1) { update(); }
L_main0:
	CALL       _update+0
	GOTO       L_main0
;gamecode.c,178 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_initialize:

;gamecode.c,180 :: 		void initialize() {
;gamecode.c,181 :: 		initPIC();
	CALL       _initPIC+0
;gamecode.c,182 :: 		initLCD();
	CALL       _initLCD+0
;gamecode.c,183 :: 		initGame();
	CALL       _initGame+0
;gamecode.c,184 :: 		}
L_end_initialize:
	RETURN
; end of _initialize

_initGame:

;gamecode.c,186 :: 		void initGame() {
;gamecode.c,190 :: 		}
L_end_initGame:
	RETURN
; end of _initGame

_initPIC:

;gamecode.c,192 :: 		void initPIC() {
;gamecode.c,193 :: 		OSCCON = 0b01110111; // 8 MHz
	MOVLW      119
	MOVWF      OSCCON+0
;gamecode.c,194 :: 		ANSEL = 0b00000000;
	CLRF       ANSEL+0
;gamecode.c,195 :: 		ANSELH = 0b00000000;
	CLRF       ANSELH+0
;gamecode.c,197 :: 		TRISA = 0b00000000;
	CLRF       TRISA+0
;gamecode.c,198 :: 		TRISB = 0b00000000;
	CLRF       TRISB+0
;gamecode.c,199 :: 		TRISC = 0b00000000;
	CLRF       TRISC+0
;gamecode.c,200 :: 		PORTA = 0b00000000;
	CLRF       PORTA+0
;gamecode.c,201 :: 		PORTB = 0b00000000;
	CLRF       PORTB+0
;gamecode.c,202 :: 		PORTC = 0b00000000;
	CLRF       PORTC+0
;gamecode.c,203 :: 		}
L_end_initPIC:
	RETURN
; end of _initPIC

_initLCD:

;gamecode.c,205 :: 		void initLCD() {
;gamecode.c,206 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;gamecode.c,207 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,208 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,211 :: 		Lcd_RS = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,212 :: 		Lcd_Cmd(64+lcdCharLength);
	MOVLW      72
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,213 :: 		Lcd_RS = 1;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,215 :: 		for(i = 0; i < tileCount; i++) {
	CLRF       _i+0
	CLRF       _i+1
L_initLCD2:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__initLCD42
	MOVLW      8
	SUBWF      _i+0, 0
L__initLCD42:
	BTFSC      STATUS+0, 0
	GOTO       L_initLCD3
;gamecode.c,216 :: 		for(j = 0; j < lcdCharLength; j++) {
	CLRF       _j+0
	CLRF       _j+1
L_initLCD5:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__initLCD43
	MOVLW      8
	SUBWF      _j+0, 0
L__initLCD43:
	BTFSC      STATUS+0, 0
	GOTO       L_initLCD6
;gamecode.c,217 :: 		Lcd_Chr_Cp(tiles[i][j]);
	MOVLW      3
	MOVWF      R2+0
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__initLCD44:
	BTFSC      STATUS+0, 2
	GOTO       L__initLCD45
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__initLCD44
L__initLCD45:
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
;gamecode.c,216 :: 		for(j = 0; j < lcdCharLength; j++) {
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;gamecode.c,218 :: 		}
	GOTO       L_initLCD5
L_initLCD6:
;gamecode.c,215 :: 		for(i = 0; i < tileCount; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;gamecode.c,219 :: 		}
	GOTO       L_initLCD2
L_initLCD3:
;gamecode.c,221 :: 		Lcd_RS = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,222 :: 		Lcd_Cmd(128);
	MOVLW      128
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,223 :: 		Lcd_RS = 1;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,224 :: 		}
L_end_initLCD:
	RETURN
; end of _initLCD

_loadLevel:

;gamecode.c,226 :: 		void loadLevel(char levelIndex) {
;gamecode.c,227 :: 		for(i = 0; i < lcdHeight; i++) {
	CLRF       _i+0
	CLRF       _i+1
L_loadLevel8:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__loadLevel47
	MOVLW      4
	SUBWF      _i+0, 0
L__loadLevel47:
	BTFSC      STATUS+0, 0
	GOTO       L_loadLevel9
;gamecode.c,228 :: 		for(j = 0; j < lcdWidth; j++) {
	CLRF       _j+0
	CLRF       _j+1
L_loadLevel11:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__loadLevel48
	MOVLW      20
	SUBWF      _j+0, 0
L__loadLevel48:
	BTFSC      STATUS+0, 0
	GOTO       L_loadLevel12
;gamecode.c,229 :: 		combineTiles(levels[levelIndex][2*i][j], levels[levelIndex][2*i+1][j]);
	MOVLW      160
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       FARG_loadLevel_levelIndex+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	ADDLW      gamecode_levels+0
	MOVWF      FLOC__loadLevel+2
	MOVLW      hi_addr(gamecode_levels+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FLOC__loadLevel+3
	MOVF       _i+0, 0
	MOVWF      FLOC__loadLevel+0
	MOVF       _i+1, 0
	MOVWF      FLOC__loadLevel+1
	RLF        FLOC__loadLevel+0, 1
	RLF        FLOC__loadLevel+1, 1
	BCF        FLOC__loadLevel+0, 0
	MOVLW      20
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       FLOC__loadLevel+0, 0
	MOVWF      R4+0
	MOVF       FLOC__loadLevel+1, 0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       FLOC__loadLevel+2, 0
	ADDWF      R0+0, 1
	MOVF       FLOC__loadLevel+3, 0
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
	MOVWF      FARG_combineTiles+0
	MOVF       FLOC__loadLevel+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      FLOC__loadLevel+1, 0
	MOVWF      R0+1
	MOVLW      20
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       FLOC__loadLevel+2, 0
	ADDWF      R0+0, 1
	MOVF       FLOC__loadLevel+3, 0
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
	MOVWF      FARG_combineTiles+0
	CALL       _combineTiles+0
;gamecode.c,230 :: 		Lcd_Chr(i+1, j+1, 0);
	INCF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	INCF       _j+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	CLRF       FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;gamecode.c,228 :: 		for(j = 0; j < lcdWidth; j++) {
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;gamecode.c,231 :: 		}
	GOTO       L_loadLevel11
L_loadLevel12:
;gamecode.c,227 :: 		for(i = 0; i < lcdHeight; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;gamecode.c,232 :: 		}
	GOTO       L_loadLevel8
L_loadLevel9:
;gamecode.c,233 :: 		}
L_end_loadLevel:
	RETURN
; end of _loadLevel

_combineTiles:

;gamecode.c,235 :: 		void combineTiles(char id1, char id2) {
;gamecode.c,237 :: 		for(i = 0; i < lcdCharLength; i++) {
	CLRF       _i+0
	CLRF       _i+1
L_combineTiles14:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__combineTiles50
	MOVLW      8
	SUBWF      _i+0, 0
L__combineTiles50:
	BTFSC      STATUS+0, 0
	GOTO       L_combineTiles15
;gamecode.c,238 :: 		combinedTile[i] = tiles[id1][i] | tiles[id2][i];
	MOVF       _i+0, 0
	ADDLW      combineTiles_combinedTile_L0+0
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R2+0
	MOVF       FARG_combineTiles_id1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R2+0, 0
L__combineTiles51:
	BTFSC      STATUS+0, 2
	GOTO       L__combineTiles52
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__combineTiles51
L__combineTiles52:
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
	MOVF       FARG_combineTiles_id2+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R2+0, 0
L__combineTiles53:
	BTFSC      STATUS+0, 2
	GOTO       L__combineTiles54
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__combineTiles53
L__combineTiles54:
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
;gamecode.c,237 :: 		for(i = 0; i < lcdCharLength; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;gamecode.c,239 :: 		}
	GOTO       L_combineTiles14
L_combineTiles15:
;gamecode.c,240 :: 		Lcd_RS = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,241 :: 		Lcd_Cmd(64);
	MOVLW      64
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,242 :: 		Lcd_RS = 1;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,243 :: 		for(i = 0; i < lcdCharLength; i++) { Lcd_Chr_Cp(combinedTile[i]); }
	CLRF       _i+0
	CLRF       _i+1
L_combineTiles17:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__combineTiles55
	MOVLW      8
	SUBWF      _i+0, 0
L__combineTiles55:
	BTFSC      STATUS+0, 0
	GOTO       L_combineTiles18
	MOVF       _i+0, 0
	ADDLW      combineTiles_combinedTile_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
	GOTO       L_combineTiles17
L_combineTiles18:
;gamecode.c,244 :: 		Lcd_RS = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,245 :: 		Lcd_Cmd(128);
	MOVLW      128
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,246 :: 		Lcd_RS = 1;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
;gamecode.c,247 :: 		}
L_end_combineTiles:
	RETURN
; end of _combineTiles

_getBlockId:

;gamecode.c,249 :: 		char getBlockId(char x, char y) {
;gamecode.c,250 :: 		if(x < 0 || x > lcdWidth || y < 0 || y > lcdHeight) { return -1; }
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
	GOTO       L_getBlockId22
L__getBlockId33:
	MOVLW      255
	MOVWF      R0+0
	GOTO       L_end_getBlockId
L_getBlockId22:
;gamecode.c,251 :: 		return levels[curLevel][y][x];
	MOVLW      160
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       _curLevel+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	ADDLW      gamecode_levels+0
	MOVWF      FLOC__getBlockId+0
	MOVLW      hi_addr(gamecode_levels+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FLOC__getBlockId+1
	MOVLW      20
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       FARG_getBlockId_y+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16X16_U+0
	MOVF       FLOC__getBlockId+0, 0
	ADDWF      R0+0, 1
	MOVF       FLOC__getBlockId+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       FARG_getBlockId_x+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
;gamecode.c,252 :: 		}
L_end_getBlockId:
	RETURN
; end of _getBlockId

_checkAirborne:

;gamecode.c,254 :: 		void checkAirborne() {
;gamecode.c,257 :: 		offset = player.isFaceUp == 1 ? -1 : 1;
	MOVF       _player+3, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_checkAirborne23
	MOVLW      255
	MOVWF      ?FLOC___checkAirborneT83+0
	GOTO       L_checkAirborne24
L_checkAirborne23:
	MOVLW      1
	MOVWF      ?FLOC___checkAirborneT83+0
L_checkAirborne24:
;gamecode.c,258 :: 		below = getBlockId(player.x, player.y+offset);
	MOVF       _player+0, 0
	MOVWF      FARG_getBlockId_x+0
	MOVF       ?FLOC___checkAirborneT83+0, 0
	ADDWF      _player+1, 0
	MOVWF      FARG_getBlockId_y+0
	CALL       _getBlockId+0
	MOVF       R0+0, 0
	MOVWF      checkAirborne_below_L0+0
;gamecode.c,260 :: 		(below == spikeU && player.isFaceUp == 1) ||
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L__checkAirborne34
	MOVF       checkAirborne_below_L0+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L__checkAirborne36
	MOVF       _player+3, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkAirborne36
	GOTO       L__checkAirborne34
L__checkAirborne36:
;gamecode.c,261 :: 		(below == spikeD && player.isFaceUp == 0)) {
	MOVF       checkAirborne_below_L0+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L__checkAirborne35
	MOVF       _player+3, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkAirborne35
	GOTO       L__checkAirborne34
L__checkAirborne35:
	GOTO       L_checkAirborne31
L__checkAirborne34:
;gamecode.c,262 :: 		player.isAirborne = 1;
	MOVLW      1
	MOVWF      _player+2
;gamecode.c,263 :: 		}
L_checkAirborne31:
;gamecode.c,264 :: 		player.isAirborne = 0;
	CLRF       _player+2
;gamecode.c,265 :: 		}
L_end_checkAirborne:
	RETURN
; end of _checkAirborne

_update:

;gamecode.c,267 :: 		void update() {
;gamecode.c,288 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,289 :: 		combineTiles(0, 1);
	CLRF       FARG_combineTiles_id1+0
	MOVLW      1
	MOVWF      FARG_combineTiles_id2+0
	CALL       _combineTiles+0
;gamecode.c,290 :: 		Lcd_Chr(player.x+1, player.y+1, 0);
	INCF       _player+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	INCF       _player+1, 0
	MOVWF      FARG_Lcd_Chr_column+0
	CLRF       FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;gamecode.c,292 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_update32:
	DECFSZ     R13+0, 1
	GOTO       L_update32
	DECFSZ     R12+0, 1
	GOTO       L_update32
	NOP
	NOP
;gamecode.c,293 :: 		}
L_end_update:
	RETURN
; end of _update
