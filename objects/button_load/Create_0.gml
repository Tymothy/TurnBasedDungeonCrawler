/// @description Create load button



// Inherit the parent event
event_inherited();
property.text = "Load";
property.anchor = ANCHOR.BOTTOM_RIGHT;
property.x = 0;
property.y = -1;
property.width = 2;
property.height = 1;


create_update();

activate_button = function() {
	show_debug_message("Load button.");
	co_saveLoad.loadGame();
}