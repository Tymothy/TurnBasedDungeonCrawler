/// @description Create restart button



// Inherit the parent event
event_inherited();
property.text = "Restart";
property.anchor = ANCHOR.MIDDLE_RIGHT;
property.x = 0;
property.y = 0;
property.width = 2;
property.height = 1;


create_update();

activate_button = function() {
	show_debug_message("Restart button.");
	game_restart();
}