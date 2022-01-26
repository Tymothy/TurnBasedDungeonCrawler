/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function goal_rooms(){
	var _ret = ceil(irandom(1) + irandom(2) + 4 + global.currentFloor * 2.3);
	return _ret;
}