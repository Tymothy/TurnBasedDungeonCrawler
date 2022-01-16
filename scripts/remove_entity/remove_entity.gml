/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function remove_entity(inst = self.id){
	//Remove from priority queue, if it exists.
	if(instance_exists(co_turnOrder)) {
		co_turnOrder.removeFromQueue(inst);
	}
	
	instance_destroy(inst);
}