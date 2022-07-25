/// @description Create parent button
active = true;
gh = global.gui_height;
gw = global.gui_width;
tile = global.gui_tile_size;
//X and Y location on GUI layer
designX = gw * .5;
designY = gh * .5;

//Design in tiles
designWidth = 3;
designHeight = 2;

interact = function() {
	if(active) {
		activate_button();	
	}
}

activate_button = function() {
	show_debug_message("Default activate_button message.");
}

interact_button = function() {
	show_debug_message("Default interact_button message.");
}

on_click_button = function() {
	show_debug_message("Default on_click_button message.");
}