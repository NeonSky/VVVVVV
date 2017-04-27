
_loadMenu:

	MOVLW      77
	MOVWF      loadMenu_menuTitle_L0+0
	MOVLW      101
	MOVWF      loadMenu_menuTitle_L0+1
	MOVLW      110
	MOVWF      loadMenu_menuTitle_L0+2
	MOVLW      117
	MOVWF      loadMenu_menuTitle_L0+3
	CLRF       loadMenu_menuTitle_L0+4
	MOVLW      5
	MOVWF      loadMenu_menuTitleLength_L0+0
	MOVF       loadMenu_menuTitleLength_L0+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVF       R0+0, 0
	SUBLW      10
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      loadMenu_menuTitlePos_L0+0
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       loadMenu_menuTitlePos_L0+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       loadMenu_menuTitle_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	MOVLW      1
	MOVWF      loadMenu_i_L0+0
L_loadMenu0:
	MOVLW      1
	SUBWF      loadMenu_menuTitleLength_L0+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__loadMenu15
	MOVF       R1+0, 0
	SUBWF      loadMenu_i_L0+0, 0
L__loadMenu15:
	BTFSC      STATUS+0, 0
	GOTO       L_loadMenu1
	MOVF       loadMenu_i_L0+0, 0
	ADDLW      loadMenu_menuTitle_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	INCF       loadMenu_i_L0+0, 1
	GOTO       L_loadMenu0
L_loadMenu1:
L_end_loadMenu:
	RETURN
; end of _loadMenu

_printSelectableLevels:

	MOVLW      2
	MOVWF      FARG_min_a+0
	CLRF       FARG_min_a+1
	MOVLW      3
	MOVWF      FARG_min_b+0
	MOVLW      0
	MOVWF      FARG_min_b+1
	CALL       _min+0
	MOVF       R0+0, 0
	MOVWF      printSelectableLevels_levelsToPrint_L0+0
	MOVLW      76
	MOVWF      printSelectableLevels_baseString_L0+0
	MOVLW      101
	MOVWF      printSelectableLevels_baseString_L0+1
	MOVLW      118
	MOVWF      printSelectableLevels_baseString_L0+2
	MOVLW      101
	MOVWF      printSelectableLevels_baseString_L0+3
	MOVLW      108
	MOVWF      printSelectableLevels_baseString_L0+4
	MOVLW      32
	MOVWF      printSelectableLevels_baseString_L0+5
	CLRF       printSelectableLevels_baseString_L0+6
	MOVLW      7
	MOVWF      printSelectableLevels_numChars_L0+0
	CLRF       printSelectableLevels_i_L0+0
L_printSelectableLevels3:
	MOVF       printSelectableLevels_levelsToPrint_L0+0, 0
	SUBWF      printSelectableLevels_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_printSelectableLevels4
	MOVF       printSelectableLevels_i_L0+0, 0
	ADDLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      4
	MOVWF      FARG_Lcd_Chr_column+0
	MOVF       printSelectableLevels_baseString_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	MOVLW      1
	MOVWF      printSelectableLevels_j_L0+0
L_printSelectableLevels6:
	MOVLW      1
	SUBWF      printSelectableLevels_numChars_L0+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__printSelectableLevels17
	MOVF       R1+0, 0
	SUBWF      printSelectableLevels_j_L0+0, 0
L__printSelectableLevels17:
	BTFSC      STATUS+0, 0
	GOTO       L_printSelectableLevels7
	MOVF       printSelectableLevels_j_L0+0, 0
	ADDLW      printSelectableLevels_baseString_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	INCF       printSelectableLevels_j_L0+0, 1
	GOTO       L_printSelectableLevels6
L_printSelectableLevels7:
	MOVF       printSelectableLevels_i_L0+0, 0
	ADDWF      FARG_printSelectableLevels_start+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	INCF       FARG_Lcd_Chr_CP_out_char+0, 1
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
	INCF       printSelectableLevels_i_L0+0, 1
	GOTO       L_printSelectableLevels3
L_printSelectableLevels4:
L_end_printSelectableLevels:
	RETURN
; end of _printSelectableLevels

_updateMenu:

	MOVF       _prevMenuSelection+0, 0
	XORWF      _menuSelection+0, 0
	MOVLW      1
	BTFSC      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      updateMenu_shouldUpdate_L0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_updateMenu9
	MOVLW      3
	MOVWF      R4+0
	MOVF       _prevMenuSelection+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_menu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_updateMenu9:
	BTFSS      PORTC+0, 5
	GOTO       L_updateMenu10
	MOVF       _menuSelection+0, 0
	MOVWF      FARG_loadLevel_levelIndex+0
	CALL       _loadLevel+0
L_updateMenu10:
	MOVF       _menuSelection+0, 0
	MOVWF      _prevMenuSelection+0
	BTFSS      PORTC+0, 6
	GOTO       L_updateMenu11
	MOVLW      1
	SUBWF      _menuSelection+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      2
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _menuSelection+0
L_updateMenu11:
	BTFSS      PORTC+0, 7
	GOTO       L_updateMenu12
	MOVF       _menuSelection+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      2
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _menuSelection+0
L_updateMenu12:
	MOVF       updateMenu_shouldUpdate_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_updateMenu13
	MOVLW      3
	MOVWF      R4+0
	MOVF       _menuSelection+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_menu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_updateMenu13:
L_end_updateMenu:
	RETURN
; end of _updateMenu

menu____?ag:

L_end_menu___?ag:
	RETURN
; end of menu____?ag
