/// @description truestate_draw_current
/// @arg {real} x
/// @arg {real} y
function truestate_draw_current(argument0, argument1) {

	/// Useful debug script that draws the current state name to the screen 
	/// as well as the current state timer value.

	var _str = truestate_names[? truestate_current_state] + " ("+string(truestate_timer)+")";
	draw_text(argument0,argument1,_str);


}
