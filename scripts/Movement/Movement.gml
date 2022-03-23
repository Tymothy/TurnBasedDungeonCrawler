/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/

function move_entity(_targX, _targY, _timeMulti = 1, _twerpType = TwerpType.inout_cubic){
	/// @desc Move entity to a position nicely. Returns true when done
	/// @arg ....
	/// @arg ....
	static twerpTimer = 0;
	x = twerp(_twerpType, x, _targX, twerpTimer / (global.moveTime * _timeMulti));
	y = twerp(_twerpType, y, _targY, twerpTimer / (global.moveTime * _timeMulti));
	twerpTimer += d(1);
	
	if(floor(x) == floor(_targX) && floor(y) == floor(_targY)) {
		twerpTimer = 0;
		return true;	
	} 
	else {
		return false;	
	}
}

function remove_entity(inst = self.id){
	//Remove from priority queue, if it exists.
	if(instance_exists(co_turnOrder)) {
		co_turnOrder.removeFromQueue(inst);
	}
	//Remove from entity grid
	mp_clear_entity(id)
	instance_destroy(inst);
}
	
function clean_grid_entities(_pathID, tempEntity) {
	for(var i = 0; i < array_length(tempEntity); i++) {
		//Put the x and y array from the top array into a temp array
		var _tempArr = tempEntity[i];
			
		//Pull the x and y values from the array
		var _x = _tempArr[0];
		var _y = _tempArr[1];
			
		//_x = to_grid(_x);
		//_y = to_grid(_y);
		if(LOGGING) show_debug_message("Clearing block at: " + coords_string(_x, _y))
		mp_grid_clear_cell(_pathID, _x, _y);
	}	
}

function block_grid_tile(_pathID, _coordArray, tempEntity) {
	//Finds an alternate path after removing a specific grid square
	//PathID = Square to block
	//rx = x to block
	//ry = y to block
	//tempEntity = array that will hold all tempEntities for cleaning up later
	var _rx = _coordArray[0];
	var _ry = _coordArray[1];
	_rx = to_grid(_rx);
	_ry = to_grid(_ry);
	if(LOGGING) show_debug_message("Blocking grid square: " + coords_string(_rx, _ry));
	mp_grid_add_cell(_pathID, _rx, _ry);
	var _arrL = array_length(tempEntity);
	tempEntity[_arrL] = [_rx, _ry]; //No +1 required as array length will return 1, yet the value is in the 0 spot.
	return tempEntity;
}
	
function check_path(_xg, _yg) {
	//Give function a target x and y
	//If spot is occupied by entity, try other spots
	
	
	//Check entity grid, if filled, add to collision grid and then repath.
	//After repathing, clean up the adds	
	_xg = to_grid(_xg);
	_yg = to_grid(_yg);
	entity = check_entity(_xg, _yg);

	
	if(entity != false) {	
		//Square has an entity, we cannot move to target square
		return entity;
	}
		
	return true; // Return true if given coordinates are valid
}

function calc_path(_pathID, _xg, _yg) {
	//Init array
	_retArray[0] = -1;
	_retArray[1] = -1;
	
	var _pathResult = mp_grid_path(_pathID, entityPath, x, y, _xg, _yg, true);
	if(_pathResult == false) {
		//Target is on on a non-targetable cell, try to navigate towards it
		/*
		Ideas:
			Ensure target grid is within current room
			Check the 9 tiles around the target, and then determine closest one to the originating instance.
			Potentially going to be a wrong target
			If still no path, don't move?
		*/
	}
	else {		
		//Enemies can only move one tile at a time, per turn
		var _xx = path_get_point_x(entityPath, 1);
		var _yy = path_get_point_y(entityPath, 1);
							
		//Calc grid point to move to
		var _retX = to_grid(_xx);
		var _retY = to_grid(_yy);
	
		_retX = from_grid(_retX);
		_retY = from_grid(_retY);
		
		_retArray[0] = _retX;
		_retArray[1] = _retY;
	}

		return _retArray;
}

function setup_move() {
	entityPath = path_add();
	mp_clear_entity(); //Clears self from entity grid
			
	//Is below needed?
	//targX = -1;
	//targY = -1;
	entity = noone;
	return entityPath;
}

function move_direct(_pathID, _xg, _yg) {
	tempArr[0] = 0;
	tempArr[1] = 0;
	tempEntity[0] = [0, 0];//Sets up the array to be able to hold tempEntities from block_grid_tile
	
	setup_move();
	targArr = calc_path(_pathID, _xg, _yg); //Finds a path, then returns the x and y of one square along that path	
	var _valid = check_path(targArr[0], targArr[1]);
	
	var i = 0;
	while(_valid != true && i <= 5) {
		tempEntity = block_grid_tile(_pathID, targArr, tempEntity); //Block the spot on the grid that is currently filled with an entity.
		targArr = calc_path(_pathID, _xg, _yg);
		_valid = check_path(targArr[0], targArr[1]);
		i++;
	}
	
	if( i >= 5) {
		//Unable to find a valid spot to move to, don't allow object to move
		targArr[0] = x;
		targArr[1] = y;
	}
	clean_grid_entities(_pathID, tempEntity);
	path_delete(entityPath);
	return targArr;
}