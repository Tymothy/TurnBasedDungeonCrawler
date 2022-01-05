/// @description truestate_create_state
/// @param {real} StateEnum The enum value that represents this state for this object.
/// @param {real} Script The script that will handle step and draw for this object.
/// @param {string} [Name] Optional name to display for this state.
function truestate_create_state() {

	ds_map_replace(truestate_map,argument[0],argument[1]);
	ds_map_replace(truestate_names,argument[0],argument_count > 2 ? argument[2] : script_get_name(argument[1]));
	if(ds_map_size(truestate_map) == 1)
		truestate_set_default(argument[0]);


}
