/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function to_grid(_i){
	var _gridCoord = floor(_i / TILE_SIZE);
	return _gridCoord;
}

function coords_string(_x, _y){
	var _str = string(_x) + ", " + string(_y);
	return _str;
}

function released_at_coords (_x, _y){
	
}