/// @description truestate_queue_start 
function truestate_queue_start() {

	/// Begins the state queue.

	truestate_in_queue = ds_queue_size(truestate_queue) > 0;
	truestate_switch();
	


}
