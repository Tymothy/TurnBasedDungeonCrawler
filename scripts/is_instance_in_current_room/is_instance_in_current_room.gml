/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function is_instance_in_current_room(_inst){
	var _instX = _inst.x;
	var _instY = _inst.y;
	var _gridX = to_grid(_instX);
	var _gridY = to_grid(_instY);
	var _roomX = to_room_x(_gridX);
	var _roomY = to_room_y(_gridY);
	
	var _curRoomX = co_gameManager.currentRoomX;
	var _curRoomY = co_gameManager.currentRoomY;
	
	if(_roomX == co_gameManager.currentRoomX)	{
		if(_roomY== co_gameManager.currentRoomY) {
			return true;
		}
	}
	return false;
}