/// @description Create save button



// Inherit the parent event
event_inherited();
property.text = "Save";
property.anchor = ANCHOR.BOTTOM_RIGHT;
property.x = 0;
property.y = -2;
property.width = 2;
property.height = 1;


create_update();

activate_button = function() {
	show_debug_message("Save button.");
	co_saveLoad.save();
}