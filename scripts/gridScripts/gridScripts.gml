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

function from_grid(_i){
	var _roomCoord = _i * TILE_SIZE + TILE_SIZE / 2;
	return _roomCoord;
}

function coords_string(_x, _y){
	var _str = string(_x) + ", " + string(_y);
	return _str;
}

function released_at_grid_coords (_x, _y){
	/*
	Send coords to co_gameMaster and have co_gameMaster determine what to do with coords
	*/
	
}

function gridX_dist_to_player (_x) {
		var _dist = abs(to_grid(ob_player.x) - _x);
		return _dist;
}

function gridY_dist_to_player (_y) {
		var _dist = abs(to_grid(ob_player.y) - _y);
		return _dist;
}

function check_entity(_gridX, _gridY) {
	/// @desc Checks for entity at given grid coords.  If entity exists, return entity.  Otherwise return false.
	/// @arg gridX
	/// @arg gridY
		if(mp_grid_get_cell(co_grid.mpGrid_entity, _gridX, _gridY) == -1) {
			//Grid is occupied, return object
			var _inst = instance_position(from_grid(_gridX), from_grid(_gridY), co_trueStateActor);
			return _inst;
		}
		else {
			return false;
		}

}