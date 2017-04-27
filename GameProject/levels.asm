
_loadLevel:

	MOVLW      1
	MOVWF      loadLevel_playerX_L0+0
	MOVLW      1
	MOVWF      loadLevel_playerY_L0+0
	MOVF       FARG_loadLevel_levelIndex+0, 0
	MOVWF      levels_curLevel+0
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	CLRF       loadLevel_i_L0+0
L_loadLevel0:
	MOVLW      4
	SUBWF      loadLevel_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_loadLevel1
	CLRF       loadLevel_j_L0+0
L_loadLevel3:
	MOVLW      20
	SUBWF      loadLevel_j_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_loadLevel4
	MOVLW      160
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       levels_curLevel+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	ADDLW      levels_levels+0
	MOVWF      FLOC__loadLevel+2
	MOVLW      hi_addr(levels_levels+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FLOC__loadLevel+3
	MOVF       loadLevel_i_L0+0, 0
	MOVWF      FLOC__loadLevel+0
	CLRF       FLOC__loadLevel+1
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
	MOVF       loadLevel_j_L0+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_max_a+0
	MOVLW      0
	MOVWF      FARG_max_a+1
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
	MOVF       loadLevel_j_L0+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_max_b+0
	MOVLW      0
	MOVWF      FARG_max_b+1
	CALL       _max+0
	MOVF       R0+0, 0
	MOVWF      loadLevel_tile_L0+0
	MOVF       R0+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_loadLevel6
	INCF       loadLevel_j_L0+0, 0
	MOVWF      loadLevel_playerX_L0+0
	INCF       loadLevel_i_L0+0, 0
	MOVWF      loadLevel_playerY_L0+0
L_loadLevel6:
	INCF       loadLevel_i_L0+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	INCF       loadLevel_j_L0+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	INCF       loadLevel_tile_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
	INCF       loadLevel_j_L0+0, 1
	GOTO       L_loadLevel3
L_loadLevel4:
	INCF       loadLevel_i_L0+0, 1
	GOTO       L_loadLevel0
L_loadLevel1:
	MOVF       loadLevel_playerX_L0+0, 0
	MOVWF      FARG_initPlayer_x+0
	MOVF       loadLevel_playerY_L0+0, 0
	MOVWF      FARG_initPlayer_y+0
	MOVLW      1
	MOVWF      FARG_initPlayer_faceUp+0
	CALL       _initPlayer+0
	MOVLW      2
	MOVWF      FARG_changeGameState_newState+0
	CALL       _changeGameState+0
L_end_loadLevel:
	RETURN
; end of _loadLevel

_getTileId:

	MOVLW      0
	SUBWF      FARG_getTileId_x+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__getTileId10
	MOVF       FARG_getTileId_x+0, 0
	SUBLW      20
	BTFSS      STATUS+0, 0
	GOTO       L__getTileId10
	MOVLW      0
	SUBWF      FARG_getTileId_y+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__getTileId10
	MOVF       FARG_getTileId_y+0, 0
	SUBLW      4
	BTFSS      STATUS+0, 0
	GOTO       L__getTileId10
	GOTO       L_getTileId9
L__getTileId10:
	MOVLW      255
	MOVWF      R0+0
	GOTO       L_end_getTileId
L_getTileId9:
	MOVLW      160
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       levels_curLevel+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	ADDLW      levels_levels+0
	MOVWF      FLOC__getTileId+0
	MOVLW      hi_addr(levels_levels+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FLOC__getTileId+1
	MOVLW      1
	SUBWF      FARG_getTileId_y+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      20
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	ADDWF      FLOC__getTileId+0, 0
	MOVWF      R2+0
	MOVF       FLOC__getTileId+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVLW      1
	SUBWF      FARG_getTileId_x+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVF       R2+0, 0
	ADDWF      R0+0, 1
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
L_end_getTileId:
	RETURN
; end of _getTileId

levels____?ag:

L_end_levels___?ag:
	RETURN
; end of levels____?ag
