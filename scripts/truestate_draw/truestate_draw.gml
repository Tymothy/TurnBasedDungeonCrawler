/// @description truestate_draw
function truestate_draw() {

	/// Call this in the draw event of your object.

	if(script_exists(truestate_state_script))
	  script_execute(truestate_state_script,TRUESTATE_DRAW)
	else
	  truestate_switch(truestate_default_state);


}
