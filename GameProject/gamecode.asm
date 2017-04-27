
_main:

	CALL       _initialize+0
	CLRF       FARG_changeGameState_newState+0
	CALL       _changeGameState+0
L_main0:
	CALL       _update+0
	GOTO       L_main0
L_end_main:
	GOTO       $+0
; end of _main

_initialize:

	CALL       _initPIC+0
	CALL       _initLCD+0
L_end_initialize:
	RETURN
; end of _initialize

_initPIC:

	MOVLW      119
	MOVWF      OSCCON+0
	CLRF       ANSEL+0
	CLRF       ANSELH+0
	CLRF       TRISA+0
	CLRF       TRISB+0
	CLRF       TRISC+0
	CLRF       PORTA+0
	CLRF       PORTB+0
	CLRF       PORTC+0
L_end_initPIC:
	RETURN
; end of _initPIC

_changeGameState:

	MOVF       FARG_changeGameState_newState+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_changeGameState2
	CALL       _loadMenu+0
	CLRF       FARG_printSelectableLevels_start+0
	CALL       _printSelectableLevels+0
L_changeGameState2:
	MOVF       FARG_changeGameState_newState+0, 0
	MOVWF      _gameState+0
L_end_changeGameState:
	RETURN
; end of _changeGameState

_update:

	GOTO       L_update3
L_update5:
	CALL       _updateMenu+0
	GOTO       L_update4
L_update6:
	CALL       _movePlayer+0
	GOTO       L_update4
L_update7:
	GOTO       L_update4
L_update8:
	MOVF       gamecode_curLevel+0, 0
	ADDLW      1
	MOVWF      R1+0
	CLRF       R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update18
	MOVLW      2
	SUBWF      R1+0, 0
L__update18:
	BTFSC      STATUS+0, 0
	GOTO       L_update9
	INCF       gamecode_curLevel+0, 0
	MOVWF      FARG_loadLevel_levelIndex+0
	CALL       _loadLevel+0
	GOTO       L_update10
L_update9:
	CLRF       FARG_changeGameState_newState+0
	CALL       _changeGameState+0
L_update10:
	GOTO       L_update4
L_update11:
	CLRF       FARG_changeGameState_newState+0
	CALL       _changeGameState+0
	GOTO       L_update4
L_update3:
	MOVF       _gameState+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_update5
	MOVF       _gameState+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_update6
	MOVF       _gameState+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_update7
	MOVF       _gameState+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_update8
	MOVF       _gameState+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_update11
L_update4:
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_update12:
	DECFSZ     R13+0, 1
	GOTO       L_update12
	DECFSZ     R12+0, 1
	GOTO       L_update12
	NOP
	NOP
L_end_update:
	RETURN
; end of _update
