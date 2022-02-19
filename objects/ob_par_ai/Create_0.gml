/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

aiActive = false; //Controlled by co_gameManager on when this object can go

attributes =
{
	turnSpeed : 0, //Higher numbers will go first
	aiName : "Default Name",
}

setupMove = function(_pathName) {
	entityPath = path_add();
	mp_clear_entity(); //Clears self from entity grid
			
	//Is below needed?
	targX = -1;
	targY = -1;
	entity = noone;	
}

calcPath = function(_pathID, _xg, _yg) {
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

//TODO: CHECK PATH SHOULD ONLY CHECK A SPECIFIC SPOT, NOT TRY ITERATING
checkPath = function(_xg, _yg) {
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
	
//DUPLICATE CHECKPATH
checkPathDup = function(_pathID, _xg, _yg) {
	//Give function a target x and y
	//If spot is occupied by entity, try other spots
	
	
	//Check entity grid, if filled, add to collision grid and then repath.
	//After repathing, clean up the adds	
	_xg = to_grid(_xg);
	_yg = to_grid(_yg);
	entity = check_entity(_xg, _yg);

	
	if(entity != false) {	
		//Target cell is occupied, unable to move there.
		//Since we cannot move to target cell, try to reroute to find a valid path
				
		var i = 0;
		do {
			//Cycle through 3 iterations of pathing to see if a proper path can be found
			//Need to update gridTargX/Y
			mp_grid_add_cell(_pathID, _xg, _yg);
			tempEntityX[i] = tempArr[0];
			tempEntityY[i] = tempArr[1];
			tempArr = calcPath(_pathID, _xg, _yg);
			i++;
		}
		until (entity == false || i == 4);
				
		if(i == 4) {
			//Path not found, set targets to current position to exit infinite loop
			tempArr[0] = x;
			tempArr[1] = y;
		}
				
		//Clean up to not leave ghost collision
		for(var i = 0; i < array_length(tempEntityX); i++) {
			mp_grid_clear_cell(_pathID, tempEntityX[i], tempEntityY[i]);
		}
				
		//tempArr[0] = from_grid(_xg);
		//tempArr[1] = from_grid(_yg);					
	}
		
	return true; // Return true if given coordinates are valid
}

blockGridSquare = function(_pathID, _coordArray, tempEntity) {
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

cleanTempEntities = function(_pathID, tempEntity) {
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
	
moveDirect = function(_pathID, _xg, _yg) {
	tempArr[0] = 0;
	tempArr[1] = 0;
	tempEntity[0] = [0, 0];//Sets up the array to be able to hold tempEntities from blockGridSquare
	
	setupMove();
	targArr = calcPath(_pathID, _xg, _yg); //Finds a path, then returns the x and y of one square along that path	
	var _valid = checkPath(targArr[0], targArr[1]);
	
	var i = 0;
	while(_valid != true && i <= 5) {
		tempEntity = blockGridSquare(_pathID, targArr, tempEntity); //Block the spot on the grid that is currently filled with an entity.
		targArr = calcPath(_pathID, _xg, _yg);
		_valid = checkPath(targArr[0], targArr[1]);
		i++;
	}
	
	if( i >= 5) {
		//Unable to find a valid spot to move to, don't allow object to move
		targArr[0] = x;
		targArr[1] = y;
	}
	cleanTempEntities(_pathID, tempEntity);
	//return tempArr;
	return targArr;
}

