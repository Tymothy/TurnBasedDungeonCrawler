/// @description truestate_switch
/// @param StateEnum
/// @param [lock_switch]
function truestate_switch() {

	/// Switches to a new state at the end of this step.
	/// If you lock the state switch, any other state switches will be ignored until this change happens 
	/// the following step.
	/// Finally, if you are in the middle of executing a state queue, any state switch will be
	/// interpreted as a "go to next".  You can call this script with no arguments in that case, or to return to the default state.

	//Queue handling
	if(truestate_switch_locked) 
	{
		if(truestate_in_queue)
		{	//The locked state will interrupt the queue
			ds_queue_clear(truestate_queue);
			truestate_in_queue=false;
		}
		exit;
	}
	if(truestate_in_queue && ds_queue_size(truestate_queue)>0)
	{
		truestate_next_state = TRUESTATE_QUEUE;
		exit;
	}
	truestate_in_queue = false;

	//Switch to default
	if(argument_count == 0)
	{
		truestate_next_state = truestate_default_state;
		exit;
	}


	if(ds_map_exists(truestate_map,argument[0]))
	{
	  truestate_next_state=argument[0];
	}
	else
	{
	  show_debug_message("Tried to switch to a non-existent state("+string(argument[0])+").  Moving to default state.")
	  truestate_next_state=truestate_default_state;
	}

	//Push to stack if not locked.
	if(!truestate_stack_locked && ds_stack_top(truestate_stack) != truestate_next_state) 
	  ds_stack_push(truestate_stack,truestate_next_state);
	else
		truestate_stack_locked=false; //Reset the lock on the stack.

	if(argument_count>1)
	  truestate_switch_locked=argument[1];


}
