if(room == rm_game) {
	instance_create_layer(x, y, "la_gui_1", co_hideNonPlayableArea);
	instance_create_layer(x, y, "la_gui_2", co_minimap);
	instance_create_layer(x, y, "la_gui_2", co_gui_health);
	
	
	//Create the buttons
	//instance_create_layer(G.gw, y, "la_gui_text", co_gui_version);
	//TODO: Create an anchoring system for buttons
	//TODO: Locations of GUI is in objects themselves.  Control them from here with anchoring system
	instance_create_layer(x, y, "la_gui_buttons", button_save);
	instance_create_layer(x, y, "la_gui_buttons", button_load);
	
	
	//Create tool buttons if we are in test environment
	if(TEST) {
		instance_create_layer(x, y, "la_gui_buttons", button_hurtPlayer);
		instance_create_layer(x, y, "la_gui_buttons", button_hurtHostiles);
	}
}

instance_create_layer(x, y, "la_gui_text", co_gui_version);