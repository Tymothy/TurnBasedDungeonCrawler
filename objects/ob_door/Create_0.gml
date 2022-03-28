/// @description Create Door
event_inherited();
sprite = sp_door_wave_white;
mp_clear_entity(); //Remove door from entity collision grid
mp_clear_entity_player_collision();

sprite_index = sprite;
image_index = 3; //Set door open until locking is done

truestate_create_state(STATES.IDLE, state_door_idle, "Idle");

d_image_speed = 0;