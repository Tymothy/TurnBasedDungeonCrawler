/// @description Insert description here
// You can write your code in this editor



// Inherit the parent event
event_inherited();

sprite = sp_fire_orange_04;
sprite_index = sprite;
truestate_create_state(STATES.LOCKED, state_door_locked, "Locked");
truestate_create_state(STATES.OPEN, state_door_open, "Open");
truestate_set_default(STATES.OPEN);