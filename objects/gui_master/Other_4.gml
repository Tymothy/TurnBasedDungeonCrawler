if(room == rm_game) {
	instance_create_layer(x, y, "la_gui_1", co_hideNonPlayableArea);
	instance_create_layer(x, y, "la_gui_2", co_minimap);
	instance_create_layer(x, y, "la_gui_2", co_gui_health);
	
	
	//Create the buttons
	instance_create_layer(x, y, "la_gui_buttons", copar_button_tap);
}

instance_create_layer(x, y, "la_gui_text", co_gui_version);