/// @description truestate_cleanup
function truestate_cleanup() {

	/// Put in the cleanup event of the object.
	/// Cleans up all related data structures.
	script_execute(truestate_state_script,TRUESTATE_FINAL);
	ds_map_destroy(truestate_map);
	ds_map_destroy(truestate_names);
	ds_map_destroy(truestate_vars);
	ds_stack_destroy(truestate_stack);
	ds_queue_destroy(truestate_queue);



}
