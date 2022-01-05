/// @description truestate_step
function truestate_step() {

	/// Call this in the step event of your object.
	if(script_exists(truestate_state_script))
	  script_execute(truestate_state_script,TRUESTATE_STEP)
	else
	  truestate_switch(truestate_default_state);


}
