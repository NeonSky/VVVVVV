
_initPlayer:

	MOVF       FARG_initPlayer_x+0, 0
	MOVWF      _player+0
	MOVF       FARG_initPlayer_y+0, 0
	MOVWF      _player+1
	CLRF       _player+2
	MOVF       FARG_initPlayer_faceUp+0, 0
	MOVWF      _player+3
L_end_initPlayer:
	RETURN
; end of _initPlayer

_movePlayer:

	MOVF       _player+3, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_movePlayer0
	MOVLW      255
	MOVWF      ?FLOC___movePlayerT3+0
	GOTO       L_movePlayer1
L_movePlayer0:
	MOVLW      1
	MOVWF      ?FLOC___movePlayerT3+0
L_movePlayer1:
	MOVF       ?FLOC___movePlayerT3+0, 0
	MOVWF      movePlayer_gravityDir_L0+0
	MOVF       ?FLOC___movePlayerT3+0, 0
	MOVWF      FARG_checkAirborne_gravityDir+0
	CALL       _checkAirborne+0
	MOVF       _player+2, 0
	BTFSC      STATUS+0, 2
	GOTO       L_movePlayer2
	MOVF       movePlayer_gravityDir_L0+0, 0
	ADDWF      _player+1, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _player+1
	CALL       _clampPlayerPos+0
	GOTO       L_end_movePlayer
L_movePlayer2:
	BTFSS      PORTC+0, 6
	GOTO       L_movePlayer3
	DECF       _player+0, 0
	MOVWF      FARG_getTileId_x+0
	MOVF       _player+1, 0
	MOVWF      FARG_getTileId_y+0
	CALL       _getTileId+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_movePlayer4
	DECF       _player+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _player+0
L_movePlayer4:
	GOTO       L_movePlayer5
L_movePlayer3:
	BTFSS      PORTC+0, 7
	GOTO       L_movePlayer6
	INCF       _player+0, 0
	MOVWF      FARG_getTileId_x+0
	MOVF       _player+1, 0
	MOVWF      FARG_getTileId_y+0
	CALL       _getTileId+0
	MOVF       R0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_movePlayer7
	INCF       _player+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _player+0
L_movePlayer7:
	GOTO       L_movePlayer8
L_movePlayer6:
	BTFSS      PORTC+0, 5
	GOTO       L_movePlayer9
	COMF       _player+3, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _player+3
L_movePlayer9:
L_movePlayer8:
L_movePlayer5:
	CALL       _clampPlayerPos+0
	CALL       _updatePlayerSprite+0
	CALL       _checkCurTile+0
L_end_movePlayer:
	RETURN
; end of _movePlayer

_clampPlayerPos:

	MOVLW      1
	SUBWF      _player+1, 0
	BTFSC      STATUS+0, 0
	GOTO       L_clampPlayerPos10
	MOVLW      1
	MOVWF      _player+1
	GOTO       L_clampPlayerPos11
L_clampPlayerPos10:
	MOVF       _player+1, 0
	SUBLW      4
	BTFSC      STATUS+0, 0
	GOTO       L_clampPlayerPos12
	MOVLW      4
	MOVWF      _player+1
L_clampPlayerPos12:
L_clampPlayerPos11:
	MOVLW      1
	SUBWF      _player+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_clampPlayerPos13
	MOVLW      1
	MOVWF      _player+0
	GOTO       L_clampPlayerPos14
L_clampPlayerPos13:
	MOVF       _player+0, 0
	SUBLW      20
	BTFSC      STATUS+0, 0
	GOTO       L_clampPlayerPos15
	MOVLW      20
	MOVWF      _player+0
L_clampPlayerPos15:
L_clampPlayerPos14:
L_end_clampPlayerPos:
	RETURN
; end of _clampPlayerPos

_updatePlayerSprite:

	MOVF       _player+3, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_updatePlayerSprite16
	MOVLW      255
	MOVWF      ?FLOC___updatePlayerSpriteT17+0
	GOTO       L_updatePlayerSprite17
L_updatePlayerSprite16:
	MOVLW      1
	MOVWF      ?FLOC___updatePlayerSpriteT17+0
L_updatePlayerSprite17:
	MOVF       _player+0, 0
	MOVWF      FARG_getTileId_x+0
	MOVF       ?FLOC___updatePlayerSpriteT17+0, 0
	SUBWF      _player+1, 0
	MOVWF      FARG_getTileId_y+0
	CALL       _getTileId+0
	MOVF       R0+0, 0
	MOVWF      updatePlayerSprite_tileId_L0+0
	MOVLW      1
	ANDWF      _player+1, 0
	MOVWF      R5+0
	MOVF       _player+3, 0
	SUBLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R5+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      updatePlayerSprite_playerSprite_L0+0
	CLRF       updatePlayerSprite_i_L0+0
L_updatePlayerSprite18:
	MOVLW      8
	SUBWF      updatePlayerSprite_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_updatePlayerSprite19
	MOVF       updatePlayerSprite_i_L0+0, 0
	ADDLW      updatePlayerSprite_combinedTile_L0+0
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R2+0
	MOVF       updatePlayerSprite_playerSprite_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R2+0, 0
L__updatePlayerSprite37:
	BTFSC      STATUS+0, 2
	GOTO       L__updatePlayerSprite38
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__updatePlayerSprite37
L__updatePlayerSprite38:
	MOVLW      player_playerSprites+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(player_playerSprites+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       updatePlayerSprite_i_L0+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R3+0
	MOVLW      3
	MOVWF      R2+0
	MOVF       updatePlayerSprite_tileId_L0+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	MOVWF      R0+1
	MOVF       R2+0, 0
L__updatePlayerSprite39:
	BTFSC      STATUS+0, 2
	GOTO       L__updatePlayerSprite40
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__updatePlayerSprite39
L__updatePlayerSprite40:
	MOVLW      player_tileSprites+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(player_tileSprites+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       updatePlayerSprite_i_L0+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
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
	INCF       updatePlayerSprite_i_L0+0, 1
	GOTO       L_updatePlayerSprite18
L_updatePlayerSprite19:
	MOVLW      64
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	CLRF       updatePlayerSprite_i_L0+0
L_updatePlayerSprite21:
	MOVLW      8
	SUBWF      updatePlayerSprite_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_updatePlayerSprite22
	MOVF       updatePlayerSprite_i_L0+0, 0
	ADDLW      updatePlayerSprite_combinedTile_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	INCF       updatePlayerSprite_i_L0+0, 1
	GOTO       L_updatePlayerSprite21
L_updatePlayerSprite22:
	MOVLW      2
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      1
	SUBWF      _player+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	INCF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       _player+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	CLRF       FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
L_end_updatePlayerSprite:
	RETURN
; end of _updatePlayerSprite

_checkAirborne:

	MOVF       _player+0, 0
	MOVWF      FARG_getTileId_x+0
	MOVF       FARG_checkAirborne_gravityDir+0, 0
	ADDWF      _player+1, 0
	MOVWF      FARG_getTileId_y+0
	CALL       _getTileId+0
	MOVF       R0+0, 0
	MOVWF      checkAirborne_below_L0+0
	MOVF       R0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_checkAirborne24
	MOVLW      4
	MOVWF      FARG_changeGameState_newState+0
	CALL       _changeGameState+0
	GOTO       L_end_checkAirborne
L_checkAirborne24:
	MOVF       checkAirborne_below_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkAirborne25
	MOVLW      1
	MOVWF      ?FLOC___checkAirborneT55+0
	GOTO       L_checkAirborne26
L_checkAirborne25:
	CLRF       ?FLOC___checkAirborneT55+0
L_checkAirborne26:
	MOVF       ?FLOC___checkAirborneT55+0, 0
	MOVWF      _player+2
L_end_checkAirborne:
	RETURN
; end of _checkAirborne

_checkCurTile:

	MOVF       _player+1, 0
	MOVWF      FARG_getTileId_x+0
	MOVF       _player+0, 0
	MOVWF      FARG_getTileId_y+0
	CALL       _getTileId+0
	MOVF       R0+0, 0
	MOVWF      checkCurTile_tileId_L0+0
	MOVF       R0+0, 0
	XORLW      6
	BTFSS      STATUS+0, 2
	GOTO       L_checkCurTile27
	MOVLW      3
	MOVWF      FARG_changeGameState_newState+0
	CALL       _changeGameState+0
	GOTO       L_checkCurTile28
L_checkCurTile27:
	MOVF       checkCurTile_tileId_L0+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L__checkCurTile32
	MOVF       checkCurTile_tileId_L0+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L__checkCurTile32
	GOTO       L_checkCurTile31
L__checkCurTile32:
	MOVLW      4
	MOVWF      FARG_changeGameState_newState+0
	CALL       _changeGameState+0
L_checkCurTile31:
L_checkCurTile28:
L_end_checkCurTile:
	RETURN
; end of _checkCurTile

player____?ag:

L_end_player___?ag:
	RETURN
; end of player____?ag
