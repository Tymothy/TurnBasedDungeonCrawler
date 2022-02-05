/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function check_grid(_grid, _x, _y, _structValue = ""){
	//Returns the value of the room
	
	//Check to see if value would be out of bounds.  If so, don't check it
	if(_x <= -1 || _y <= -1 || _x >= ds_grid_width(_grid) || _y >= ds_grid_height(_grid)) {
		//Trying to check out of bounds, return noone
		return noone;
	}
	
	if(_structValue == "") var _ret = _grid[# _x, _y];
	else var _ret = _grid[# _x, _y][$string(_structValue)];
	
	return _ret;
}