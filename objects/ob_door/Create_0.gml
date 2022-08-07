/// @description Create Door
event_inherited();
sprite = sp_door_wave_white;
alarm[0] = 1; //Remove the wall from the tile map

sprite_index = sprite;
image_index = 0; //Set door to locked status
image_speed = 0;

truestate_create_state(STATES.LOCKED, state_door_locked, "Locked");
truestate_create_state(STATES.OPEN, state_door_open, "Open");
truestate_set_default(STATES.OPEN);


open = false;


