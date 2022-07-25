/// @description Create parent button
active = true;

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