/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

attributes =
{
	turnSpeed : 1, //Higher numbers will go first
	aiName : "Slime",
}
truestate_create_state(STATES.IDLE, state_ai_slime_idle);
