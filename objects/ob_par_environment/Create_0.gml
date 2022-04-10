/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//Door Methods
openDoor = function() {
	image_index = 3; //TODO: SET THIS TO AN ANIMATION
	open = true;
	if(LOGGING) show_debug_message("Unlocking door");
}

lockDoor = function() {
	image_index = 0;
	open = false;
	if(LOGGING) show_debug_message("Locking door");
}
