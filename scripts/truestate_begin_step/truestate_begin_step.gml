/// @description truestate_draw_gui_end
/// Script that executes before all other logic has been performed for the object.
/// Will perform the ACTUAL state switching, and also resets timers.
function truestate_begin_step() {

	var _is_new = false;
	truestate_switch_locked=false; //Release the lock

	if(truestate_next_state != truestate_current_state || truestate_reset_state)
	{ //Switch to the new state
	  script_execute(truestate_state_script,TRUESTATE_FINAL);
	
		truestate_previous_state=truestate_current_state;
		truestate_reset_state=false;
		if(truestate_next_state == TRUESTATE_QUEUE)
		{
			 truestate_next_state=ds_queue_dequeue(truestate_queue);	
			 ds_stack_push(truestate_stack,truestate_next_state);
		}
	
	  truestate_current_state=truestate_next_state;
	  truestate_state_script=truestate_map[? truestate_current_state];
	  truestate_timer=0;
	  script_execute(truestate_state_script,TRUESTATE_NEW);
	  _is_new = true;
	}
	else
	{ //Increment current state timer
	  truestate_timer++;
	  _is_new = false;
	}

	return _is_new;





}
