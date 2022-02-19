/// @description Create Door
event_inherited();
sprite = sp_door;
mp_clear_entity(); //Remove door from entity collision grid
mp_clear_entity_player_collision();

sprite_index = sprite;

truestate_create_state(STATES.IDLE, state_door_idle, "Idle");