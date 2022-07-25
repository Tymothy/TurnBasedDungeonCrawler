/// @description Create parent button
text = "NaN";
active = true;
clicked = false;
touchState = get_touch_state_on_change();
gh = global.gui_height;
gw = global.gui_width;
tile = global.gui_tile_size;
//X and Y location on GUI layer
designX = gw * .5;
designY = gh * .5;

//Design in tiles
designWidth = 3;
designHeight = 2;

width = designWidth * tile;
height = designHeight * tile;

x1 = designX;
y1 = designY;
x2 = designX + width;
y2 = designY + height;

drawColor = c_lime;

activate_button = function() {
	show_debug_message("Default activate_button message.");
}

interact_button = function() {
	show_debug_message("Default interact_button message.");
}

on_click_button = function() {
	show_debug_message("Default on_click_button message.");
}