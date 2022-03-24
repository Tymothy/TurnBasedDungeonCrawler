/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function to_grid(_actualCoord){
	//Returns the grid coord given an actual coord
	var _gridCoord = floor(_actualCoord / TILE_SIZE);
	return _gridCoord;
}

function from_grid(_gridCoord){
	//Returns actual coord given a grid coord
	var _actualCoord = _gridCoord * TILE_SIZE + TILE_SIZE / 2;
	return _actualCoord;
}

function to_room_x(_gridCoord){
	//Returns the room coord of a given grid coord
	var _roomCoord = floor(_gridCoord / ROOM_SIZE_WIDTH);
	return _roomCoord;	
}

function to_room_y(_gridCoord){
	//Returns the room coord of a given grid coord
	var _roomCoord = floor(_gridCoord / ROOM_SIZE_HEIGHT);
	return _roomCoord;	
}

function from_room_x(_roomCoord) {
	//Returns the center grid coord of a room
	var _gridCoord = _roomCoord * ROOM_SIZE_WIDTH + floor(ROOM_SIZE_WIDTH / 2);
	return _gridCoord;
}

function from_room_y(_roomCoord) {
	//Returns the center grid coord of a room
	var _gridCoord = _roomCoord * ROOM_SIZE_HEIGHT + floor(ROOM_SIZE_HEIGHT / 2);
	return _gridCoord;
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

