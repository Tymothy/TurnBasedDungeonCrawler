/// @description Create Door
event_inherited();
sprite = sp_door_wave_white;
mp_clear_entity(); //Remove door from entity collision grid
mp_clear_entity_player_collision();

sprite_index = sprite;
image_index = 0; //Set door to locked status

truestate_create_state(STATES.LOCKED, state_door_locked, "Locked");
truestate_create_state(STATES.OPEN, state_door_open, "Open");

d_image_speed = 0;

open = false;


