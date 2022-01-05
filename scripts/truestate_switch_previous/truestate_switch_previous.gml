/// @description truestate_switch_previous Returns to the previous state.
function truestate_switch_previous() {
	if(truestate_in_queue)
	{	
		truestate_switch();
		exit;
	}
	if(ds_stack_empty(truestate_stack))
	{
		truestate_switch(truestate_default_state);
		exit;
	}

	ds_stack_pop(truestate_stack);
	truestate_stack_locked=true;
	truestate_switch(ds_stack_top(truestate_stack));



}
