
_initLCD:

	CALL       _Lcd_Init+0
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      72
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	CLRF       initLCD_i_L0+0
L_initLCD0:
	MOVLW      7
	SUBWF      initLCD_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_initLCD1
	CLRF       initLCD_j_L0+0
L_initLCD3:
	MOVLW      8
	SUBWF      initLCD_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_initLCD4
	MOVLW      3
	MOVWF      R2+0
	MOVF       initLCD_i_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R2+0, 0
L__initLCD7:
	BTFSC      STATUS+0, 2
	GOTO       L__initLCD8
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__initLCD7
L__initLCD8:
	MOVLW      lcd_tileSprites+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(lcd_tileSprites+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       initLCD_j_L0+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	INCF       initLCD_j_L0+0, 1
	GOTO       L_initLCD3
L_initLCD4:
	INCF       initLCD_i_L0+0, 1
	GOTO       L_initLCD0
L_initLCD1:
	MOVLW      2
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
L_end_initLCD:
	RETURN
; end of _initLCD

lcd____?ag:

L_end_lcd___?ag:
	RETURN
; end of lcd____?ag
