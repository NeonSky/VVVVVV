
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
;gamecode.c,28 :: 		}
L_end_update:
	RETURN
; end of _update

_initialize:

;gamecode.c,31 :: 		void initialize() {
;gamecode.c,32 :: 		initPIC();
	CALL       _initPIC+0
;gamecode.c,33 :: 		initLCD();
	CALL       _initLCD+0
;gamecode.c,35 :: 		for(i = 1; i <= 10; i++) {
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
	SUBLW      10
L__initialize11:
	BTFSS      STATUS+0, 0
	GOTO       L_initialize3
;gamecode.c,36 :: 		Lcd_Chr(1, i, 0);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	CLRF       FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;gamecode.c,37 :: 		Lcd_Chr(2, i, 1);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;gamecode.c,38 :: 		Lcd_Chr(3, i, 2);
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;gamecode.c,39 :: 		Lcd_Chr(4, i, 3);
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;gamecode.c,35 :: 		for(i = 1; i <= 10; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;gamecode.c,40 :: 		}
	GOTO       L_initialize2
L_initialize3:
;gamecode.c,42 :: 		for(i = 11; i <= 20; i++) {
	MOVLW      11
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_initialize5:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__initialize12
	MOVF       _i+0, 0
	SUBLW      20
L__initialize12:
	BTFSS      STATUS+0, 0
	GOTO       L_initialize6
;gamecode.c,43 :: 		Lcd_Chr(1, i, 4);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;gamecode.c,44 :: 		Lcd_Chr(2, i, 5);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      5
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;gamecode.c,45 :: 		Lcd_Chr(3, i, 6);
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      6
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;gamecode.c,46 :: 		Lcd_Chr(4, i, 'V');
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      86
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;gamecode.c,42 :: 		for(i = 11; i <= 20; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;gamecode.c,47 :: 		}
	GOTO       L_initialize5
L_initialize6:
;gamecode.c,48 :: 		}
L_end_initialize:
	RETURN
; end of _initialize

_initPIC:

;gamecode.c,50 :: 		void initPIC() {
;gamecode.c,51 :: 		OSCCON = 0b01110111; // 8 MHz
	MOVLW      119
	MOVWF      OSCCON+0
;gamecode.c,52 :: 		ANSEL = 0b00000000;
	CLRF       ANSEL+0
;gamecode.c,53 :: 		ANSELH = 0b00000000;
	CLRF       ANSELH+0
;gamecode.c,55 :: 		TRISA = 0b00000000;
	CLRF       TRISA+0
;gamecode.c,56 :: 		TRISB = 0b00000000;
	CLRF       TRISB+0
;gamecode.c,57 :: 		TRISC = 0b00000000;
	CLRF       TRISC+0
;gamecode.c,58 :: 		PORTA = 0b00000000;
	CLRF       PORTA+0
;gamecode.c,59 :: 		PORTB = 0b00000000;
	CLRF       PORTB+0
;gamecode.c,60 :: 		PORTC = 0b00000000;
	CLRF       PORTC+0
;gamecode.c,61 :: 		}
L_end_initPIC:
	RETURN
; end of _initPIC

_initLCD:

;gamecode.c,63 :: 		void initLCD() {
;gamecode.c,64 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;gamecode.c,65 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,66 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,68 :: 		Lcd_RS = 0;
	BCF        RB4_bit+0, 4
;gamecode.c,69 :: 		Lcd_Cmd(64);
	MOVLW      64
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,70 :: 		Lcd_RS = 1;
	BSF        RB4_bit+0, 4
;gamecode.c,73 :: 		Lcd_Chr_Cp(0b00001010);
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,74 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,75 :: 		Lcd_Chr_Cp(0b00010001);
	MOVLW      17
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,76 :: 		Lcd_Chr_Cp(0b00001110);
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,77 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,78 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,79 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,80 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,83 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,84 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,85 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,86 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,87 :: 		Lcd_Chr_Cp(0b00001010);
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,88 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,89 :: 		Lcd_Chr_Cp(0b00010001);
	MOVLW      17
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,90 :: 		Lcd_Chr_Cp(0b00001110);
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,93 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,94 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,95 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,96 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,97 :: 		Lcd_Chr_Cp(0b00001110);
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,98 :: 		Lcd_Chr_Cp(0b00010001);
	MOVLW      17
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,99 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,100 :: 		Lcd_Chr_Cp(0b00001010);
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,103 :: 		Lcd_Chr_Cp(0b00001110);
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,104 :: 		Lcd_Chr_Cp(0b00010001);
	MOVLW      17
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,105 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,106 :: 		Lcd_Chr_Cp(0b00001010);
	MOVLW      10
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,107 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,108 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,109 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,110 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,113 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,114 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,115 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,116 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,117 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,118 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,119 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,120 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,123 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,124 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,125 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,126 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,127 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,128 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,129 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,130 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,133 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,134 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,135 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,136 :: 		Lcd_Chr_Cp(0b00000000);
	CLRF       FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,137 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,138 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,139 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,140 :: 		Lcd_Chr_Cp(0b00011111);
	MOVLW      31
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;gamecode.c,142 :: 		Lcd_RS = 0;
	BCF        RB4_bit+0, 4
;gamecode.c,143 :: 		Lcd_Cmd(128);
	MOVLW      128
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;gamecode.c,144 :: 		Lcd_RS = 1;
	BSF        RB4_bit+0, 4
;gamecode.c,145 :: 		}
L_end_initLCD:
	RETURN
; end of _initLCD
