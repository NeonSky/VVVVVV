
_main:

;gamecode.c,21 :: 		void main() {
;gamecode.c,22 :: 		initialize();
	CALL       _initialize+0
;gamecode.c,23 :: 		while(1) { update(); }
L_main0:
	CALL       _update+0
	GOTO       L_main0
;gamecode.c,24 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_update:

;gamecode.c,26 :: 		void update() {
;gamecode.c,27 :: 		}
L_end_update:
	RETURN
; end of _update

_initialize:

;gamecode.c,30 :: 		void initialize() {
;gamecode.c,31 :: 		initPIC();
	CALL       _initPIC+0
;gamecode.c,32 :: 		initLCD();
	CALL       _initLCD+0
;gamecode.c,34 :: 		for(i = 1; i <= 4; i++) {
	MOVLW      1
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_initialize2:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__initialize11
	MOVF       _i+0, 0
	SUBLW      4
L__initialize11:
	BTFSS      STATUS+0, 0
	GOTO       L_initialize3
;gamecode.c,35 :: 		for(j = 1; j <= 20; j++) {
	MOVLW      1
	MOVWF      _j+0
	MOVLW      0
	MOVWF      _j+1
L_initialize5:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _j+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__initialize12
	MOVF       _j+0, 0
	SUBLW      20
L__initialize12:
	BTFSS      STATUS+0, 0
	GOTO       L_initialize6
;gamecode.c,36 :: 		Lcd_Chr(i, j, j%4);
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _j+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      4
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;gamecode.c,35 :: 		for(j = 1; j <= 20; j++) {
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;gamecode.c,37 :: 		}
	GOTO       L_initialize5
L_initialize6:
;gamecode.c,34 :: 		for(i = 1; i <= 4; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;gamecode.c,38 :: 		}
	GOTO       L_initialize2
L_initialize3:
;gamecode.c,39 :: 		}
L_end_initialize:
	RETURN
; end of _initialize

_initPIC:

;gamecode.c,41 :: 		void initPIC() {
;gamecode.c,42 :: 		OSCCON = 0b01110111; // 8 MHz
	MOVLW      119
	MOVWF      OSCCON+0
;gamecode.c,43 :: 		ANSEL = 0b00000000;
	CLRF       ANSEL+0
;gamecode.c,44 :: 		ANSELH = 0b00000000;
	CLRF       ANSELH+0
;gamecode.c,46 :: 		TRISA = 0b00000000;
	CLRF       TRISA+0
;gamecode.c,47 :: 		TRISB = 0b00000000;
	CLRF       TRISB+0
;gamecode.c,48 :: 		TRISC = 0b00000000;
	CLRF       TRISC+0
;gamecode.c,49 :: 		PORTA = 0b00000000;
	CLRF       PORTA+0
;gamecode.c,50 :: 		PORTB = 0b00000000;
	CLRF       PORTB+0
;gamecode.c,51 :: 		PORTC = 0b00000000;
	CLRF       PORTC+0
;gamecode.c,52 :: 		}
L_end_initPIC:
	RETURN
; end of _initPIC

_initLCD:

;gamecode.c,54 :: 		void initLCD() {
;gamecode.c,55 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;gamecode.c,56 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,57 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,59 :: 		LCD_RS = 0;
	BCF        RB4_bit+0, 4
;gamecode.c,60 :: 		LCD_Cmd(64);
	MOVLW      64
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,61 :: 		LCD_RS = 1;
	BSF        RB4_bit+0, 4
;gamecode.c,64 :: 		LCD_Chr_Cp(0b00001010);
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,65 :: 		LCD_Chr_Cp(0b00010001);
	MOVLW      17
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,66 :: 		LCD_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,67 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,68 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,69 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,70 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,71 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,74 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,75 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,76 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,77 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,78 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,79 :: 		LCD_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,80 :: 		LCD_Chr_Cp(0b00010001);
	MOVLW      17
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,81 :: 		LCD_Chr_Cp(0b00001010);
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,84 :: 		LCD_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,85 :: 		LCD_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,86 :: 		LCD_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,87 :: 		LCD_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,88 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,89 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,90 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,91 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,94 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,95 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,96 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,97 :: 		LCD_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,98 :: 		LCD_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,99 :: 		LCD_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,100 :: 		LCD_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,101 :: 		LCD_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,103 :: 		LCD_RS = 0;
	BCF        RB4_bit+0, 4
;gamecode.c,104 :: 		LCD_Cmd(128);
	MOVLW      128
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,105 :: 		LCD_RS = 1;
	BSF        RB4_bit+0, 4
;gamecode.c,106 :: 		}
L_end_initLCD:
	RETURN
; end of _initLCD
