/// @description Create a ladder down
event_inherited();
sprite = sp_stair_down;
//Act like door, allowing player to go down when unlocked
truestate_create_state(STATES.LOCKED, state_door_locked, "Locked");
truestate_create_state(STATES.OPEN, state_door_open, "Open");
truestate_set_default(STATES.OPEN);
sprite_index = sprite;
