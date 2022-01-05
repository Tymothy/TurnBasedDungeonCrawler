/// @description truestate_system_init
function truestate_system_init() {

	/// Initilize the variables required for the state engine.
	/// Call this on any object you want to use the state machine in the create event.

	//These are important for the state machine.
#macro TRUESTATE_STEP 0
#macro TRUESTATE_DRAW 1
#macro TRUESTATE_NEW 2
#macro TRUESTATE_FINAL 3
#macro TRUESTATE_QUEUE 9999 

	truestate_current_state  = noone;
	truestate_default_state  = noone;
	truestate_previous_state = noone;
	truestate_next_state     = noone;
	truestate_state_script   = noone;

	truestate_switch_locked  = false;
	truestate_stack_locked   = false;
	truestate_reset_state    = false;
	truestate_in_queue       = false;

	truestate_map   = ds_map_create();
	truestate_names = ds_map_create(); 
	truestate_vars  = ds_map_create(); //Useful for storing variables specific to a specific state
	truestate_stack = ds_stack_create();
	truestate_queue = ds_queue_create();

	truestate_timer = 0;



}
