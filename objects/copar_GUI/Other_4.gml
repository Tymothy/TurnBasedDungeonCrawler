/// @description Create GUI on room start
//MUST OVERRIDE ON ALL CHILDREN
//Create the game room GUI
if(room == rm_game) {
	instance_create_layer(x, y, "la_gui_1", co_hideNonPlayableArea);
	instance_create_layer(x, y, "la_gui_2", co_minimap);
}