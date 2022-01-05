/// @description truestate_set_default
/// @param StateEnum
function truestate_set_default(argument0) {

	/// Sets the default/first state for the object.  Called only in the create event, typically after you've defined
	/// all the states for this object.

	truestate_current_state=argument0;
	truestate_state_script=ds_map_find_value(truestate_map,argument0);    

	truestate_default_state = truestate_current_state;

	truestate_next_state=truestate_current_state;
	ds_stack_push(truestate_stack,truestate_current_state);
	script_execute(truestate_state_script,TRUESTATE_NEW);



}
