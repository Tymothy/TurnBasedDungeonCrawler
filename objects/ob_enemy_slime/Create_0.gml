/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

attributes =
{
	turnSpeed : 1, //Higher numbers will go first
	aiName : "Slime",
	collisionGrid : co_grid.mpGrid_collideOther,
	targetObject : ob_player,
}
truestate_create_state(STATES.IDLE, state_ai_slime_idle);
truestate_create_state(STATES.MOVE, state_ai_slime_move);
truestate_create_state(STATES.FLEE, state_ai_slime_flee);
truestate_create_state(STATES.ATTACK, state_ai_slime_attack);
truestate_create_state(STATES.HURT, state_ai_slime_hurt);