/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//Door Methods
openDoor = function() {
	mp_clear_entity(); //Remove door from entity collision grid
	mp_clear_entity_player_collision();
	image_index = 3; //TODO: SET THIS TO AN ANIMATION
	open = true;
	if(LOGGING) show_debug_message("Unlocking door");
}

lockDoor = function() {
	mp_add_entity(); //Remove door from entity collision grid
	mp_add_entity_player_collision();
	image_index = 0;
	open = false;
	if(LOGGING) show_debug_message("Locking door");
}


