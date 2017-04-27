#ifndef GAME_STATE_H_
#define GAME_STATE_H_

typedef enum GameState {
  ST_MENU,
	ST_PAUSE,
	ST_INGAME
} GameState;
extern GameState gameState;

void changeGameState(GameState newState);

#endif
