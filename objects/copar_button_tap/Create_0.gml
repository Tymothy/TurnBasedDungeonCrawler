/// @description Insert description here
// You can write your code in this editor



// Inherit the parent event
event_inherited();

interact = function() {
	show_debug_message("Tap interact message.");
	if(active && clicked) {
		activate_button();	
	}
}

activate_button = function() {
	show_debug_message("Tap activate_button message.");
	drawColor = c_red;
	
}

on_click_button = function() {
	show_debug_message("Tap on_click_button message.");
	drawColor = c_aqua;
	clicked = true;
}

unclick_button = function() {
	show_debug_message("Unclicked.");
	clicked = false;	
}