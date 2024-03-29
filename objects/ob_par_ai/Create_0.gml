/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

aiActive = false; //Controlled by co_gameManager on when this object can go
moveCounter = 0; //Counts number of moves completed on a turn.  Reset to 0 ever time we go to idle/wait

stateMachine = true;
truestate_create_state(STATES.WAIT, state_ai_wait);
truestate_create_state(STATES.ATTACK, state_ai_attack);
truestate_create_state(STATES.MOVE, state_ai_move);
truestate_create_state(STATES.HURT, state_ai_hurt);
