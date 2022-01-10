/// @description Insert description here
//event_inherited(); //Comment out to disable GUI state debug

//Draws the current game state
draw_text(5, global.height_gui - 20, string(truestate_current_state) + " - " + truestate_get_name(truestate_current_state));