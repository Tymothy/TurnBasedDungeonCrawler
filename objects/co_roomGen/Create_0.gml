/// @description Create floor of rooms

//Configure loader
//global.roomTilesList = ds_list_create();



/*
Generate the floor plan
 - Each floor has a max size of 9x9
	- Use Binding of Isaac grid.  Label cells numerically so the ones digit is the x position, tens digit is the y position
 - Generate number of rooms on a floor
	- TODO: Determine a formula.  BoI uses random(2) + 5 + level * 2.6.  This gives first level 7 or 8 rooms, increasing by 2 or 3 each time
 - Place the spawn room in the middle of the floor, in cell 44
 - Determine if a cell is a room or not
	- Loop until desired rooms are reached
		- Find the 4 rooms around the curent room by doing +10/-10/+1/-1 to the room number
		- If the cell is occupied, stop
		- If the neighbor cell has more than one filled neighbor, stop (stops loops)
		- If max rooms have been found, stop
		- Random 50% chance to stop anyways
		- Mark the cel
		
Implementation
Cells should be a ds grid of structs
Create an 8x8 DS Grid

Minimap (used for debugging initally)
 - Show at the top of the screen, above the play area
 - Each cell in minimap is 1/2 the size of a normal tile.  This allows minimap to fit into a 4x4 area
 - Cells that have paths between them should have a blue door

*/

//Init the level grid
levelGrid = ds_grid_create(FLOOR_MAX_HEIGHT, FLOOR_MAX_WIDTH);



generateFloorPlan = function() {
	if(!ds_exists(levelGrid, ds_type_grid)) {
		levelGrid = ds_grid_create(FLOOR_MAX_HEIGHT, FLOOR_MAX_WIDTH);
	}
	//Fill the grid with "empty" rooms (Solid earth/no rooms)
	for(var i = 0; i < FLOOR_MAX_WIDTH; i++) {
		for(var j = 0; j < FLOOR_MAX_HEIGHT; j++) {
			generateRoom(i, j, ROOMTYPE.NONE);
		}
	}	
	//Generate spawn room in the middle
	var _spawnX = floor(FLOOR_MAX_WIDTH / 2);
	var _spawnY = floor(FLOOR_MAX_HEIGHT / 2);
	generateRoom(_spawnX, _spawnY, ROOMTYPE.SPAWN);
	//Blank slate of rooms generated.
	goalRooms = goal_rooms();	
	//goalRooms = 12;//Hard set to test
	createdRooms = 1;	//Starts at 1 as spawn room is already created.


	
	//Set inital room to search from at spawn
	var _x = _spawnX;
	var _y = _spawnY;
	
	for(var i = 0; i < 1000 && createdRooms < goalRooms; i++) {
		//Holds the room we started at
		var _startX = _x; 
		var _startY = _y;

		//Randomize the start direction
		var _dir = irandom(3);  //0 = East, goes counter clockwise		

		_x = getDirectionCoordX(_dir, _x);
		_y = getDirectionCoordY(_dir, _y);
		
		var _result = determineRoomGen(_x, _y);
		//See if room has already been filled
		if(_result == true) {
			//Room was generated successfully at x and y coords	
			//Move the pointer to the created room
			generateRoom(_x, _y, ROOMTYPE.NORMAL);
			createdRooms++;
			_startX = _x;
			_startY = _y;
		
			//BONUS ROOM
			if(true) {
					var _bdir = irandom(3);  //0 = East, goes counter clockwise	
					var _bx = _x;
					var _by = _y;
					_bx = getDirectionCoordX(_bdir, _bx);
					_by = getDirectionCoordY(_bdir, _by);	
					_result = determineRoomGen(_bx, _by);
					if(_result == true){
						generateRoom(_bx, _by, ROOMTYPE.NORMAL);
						createdRooms++;
					}
			}
			
		}
		else {
			//Room was not generated successfully at x and y coords
			//Set values back to start to try again
			_x = _startX;
			_y = _startY;
			//Random chance to start at the beginning
			var _rand = irandom(5);
			if(_rand == 0) {
				_x = _spawnX;
				_y = _spawnY;
			}

		}
		
		
	}
	
	
findDistanceToSpawn();
findEndRooms();


		var _spawnX = floor(FLOOR_MAX_WIDTH / 2);
		var _spawnY = floor(FLOOR_MAX_HEIGHT / 2);
	if(getCountOfNeighbors(_spawnX, _spawnY) < 2) {
		generateFloorPlan();	
	}

	while(createdRooms != goalRooms) {
		show_debug_message("Not enough rooms created.  Retrying...");
		generateFloorPlan();	
	}	

	if(array_length(endRoomArray) < 3) {
		generateFloorPlan();	
	}
}

getDirectionCoordX = function(_dir, _x) {
		//If the x or y is out of bounds, try to skip it
		switch(_dir) {
			case 0:
			//Search East
				if(_x < FLOOR_MAX_WIDTH - 1) {
					_x++;
					break;
				}
			case 1:
			//Search South
				break;
			case 2:
			//Search West
				if(_x > 0) {
				_x--;
				break;
			}
			case 3:

			break;			//This is the last check, so break regardless
		}	
		return _x;
}

getDirectionCoordY = function(_dir, _y) {
		//If the x or y is out of bounds, try to skip it
		switch(_dir) {
			case 0:
			//Search East
				break;
				
			case 1:
			//Search South
				if(_y < FLOOR_MAX_HEIGHT - 1) {
				_y++;
				break;
				}
				
			case 2:
			//Search West
				break;
			case 3:
			//Search North
				if(_y > 0) {
				_y--;
				}
			break;			//This is the last check, so break regardless
		}	
		return _y;
}

getCountOfNeighbors = function(_x, _y) {
//Check if the room already has 2 neighbors
		var _neighbors = 0;
		
		//Check to ensure we are not checking a blank/none room
		var _tempRoom = levelGrid[# _x, _y][$ "roomType"];
		if(_tempRoom == ROOMTYPE.NONE) {
			return -1;	
		}
		
		if(_x > 1){
			var _tempRoom = levelGrid[# _x - 1, _y][$ "roomType"];
			if(_tempRoom != ROOMTYPE.NONE) {
				//Room is a filled cell
				_neighbors++
			}
		}
		
		if(_x < FLOOR_MAX_WIDTH - 1) {
			var _tempRoom = levelGrid[# _x + 1, _y][$ "roomType"];
			if(_tempRoom != ROOMTYPE.NONE) {
				//Room is a filled cell
				_neighbors++
			}
		}
		
		if(_y > 1) {
			var _tempRoom = levelGrid[# _x, _y - 1][$ "roomType"];
			if(_tempRoom != ROOMTYPE.NONE) {
				//Room is a filled cell
				_neighbors++
			}
		}
		
		if(_y < FLOOR_MAX_HEIGHT - 1) {
			var _tempRoom = levelGrid[# _x, _y + 1][$ "roomType"];
			if(_tempRoom != ROOMTYPE.NONE) {
				//Room is a filled cell
				_neighbors++
			}
		}
		
		return _neighbors;
	
}

determineRoomGen = function(_x, _y) {
				
		//Check has already been generated. 
		var _roomType = levelGrid[# _x, _y][$ "roomType"];
		if(_roomType != ROOMTYPE.NONE) {
			return false;
		}		
	
		//Check if the room already has 2 neighbors
		var _neighbors = getCountOfNeighbors(_x, _y);
		
		if(_neighbors > 2) {
			//Stop if the cell has at least 2 neighbors to prevent loops
			return false;	
		}

		//Random chance to just fail to create ends
		var _rand = irandom(1);
		
		if(_rand == 0) {
			return true;	
		}
		else {
			return false;	
		}

	//This should never occur, but implemented as a fail safe
	return false;
}

generateRoom = function(_x, _y, _roomType) {
	//Sets the room type given x, y coords, and the room type to set through ENUM
	/*
	Blank/No			ROOMTYPE.NONE
	Normal/Standard		ROOMTYPE.NORMAL
	Spawn				ROOMTYPE.SPAWN
	Boss				ROOMTYPE.BOSS
	
	*/
			var	_floorStruct = new floorRoom(0, 0);
			switch(_roomType) {
				case ROOMTYPE.NONE:
					_floorStruct = new floorRoom(_x, _y);
					break;
				
				case ROOMTYPE.NORMAL:
					_floorStruct = new normalRoom(_x, _y);
					break;
				
				case ROOMTYPE.SPAWN:
					_floorStruct = new spawnRoom(_x, _y);
					break;
				
				case ROOMTYPE.BOSS:
					_floorStruct = new bossRoom(_x, _y);
					break;
					
				case ROOMTYPE.ITEM:
					_floorStruct = new itemRoom(_x, _y);
					break;			
					
				case ROOMTYPE.SHOP:
					_floorStruct = new shopRoom(_x, _y);
					break;								
			}
			ds_grid_set(levelGrid, _floorStruct.x, _floorStruct.y, _floorStruct);		
	
}
//Floor plan is very straight, with no branches.
//TODO: Come back and revise this to make more branches and not so linear
//BoI uses a queue and then iterates over the entire queue.  Currently we just create a snake

findEndRooms = function(){
	//Iterate through level grid, finding all rooms that only have a single neighbor
	if(variable_instance_exists(id, "endRoomArray")) {
		array_delete(endRoomArray, 0, array_length(endRoomArray));
	}
	endRoomArray = [[]]; //Initalize array of all end rooms that can be used for later generation
	array_pop(endRoomArray); //Get rid of the empty value to prevent off by one errors
	for(var _x = 0; _x < FLOOR_MAX_WIDTH; _x++) {
		for(var _y = 0; _y < FLOOR_MAX_HEIGHT; _y++) {
			var _neighbors = getCountOfNeighbors(_x, _y);
			if(_neighbors == 1) {
				//This is an end room
				endRoomArray = store_coordinate(endRoomArray, _x, _y);
				setEndRoom(_x, _y);
			}
		}
	}
	//Ensure spawn room is not removed
	show_debug_message("End Rooms: " + string(array_length(endRoomArray)));

	
}

findDistanceToSpawn = function() {
	//Iterate through level grid, getting direct distance to spawn room.  Does not account for winding passages
	//TODO: Improve this to take account for winding passages.  Maybe set distance at room creation
	for(var _x = 0; _x < FLOOR_MAX_WIDTH; _x++) {
		for(var _y = 0; _y < FLOOR_MAX_HEIGHT; _y++) {
			var _dist = abs(_x - floor(FLOOR_MAX_WIDTH / 2)) + abs(_y - floor(FLOOR_MAX_HEIGHT / 2));
			setDistanceToSpawn(_x, _y, _dist);
		}
	}	
	
}

generateEndRooms = function() {
	var _x = 0;
	var _y = 0;
	var _topDist = 0;
	var _selection = 0;
	
	#region Boss Room
	for(var _i = 0; _i < array_length(endRoomArray); _i++) {	
		_x = endRoomArray[_i][0]; //Get the x value of coord
		_y = endRoomArray[_i][1]; //Get the y value of coord
		
		var _dist = check_grid(co_roomGen.levelGrid, _x, _y, "distanceToSpawn");
		//Find farthest end room and set it to a boss room
		
		//TODO: Put a little more randomness here, otherwise we are favoring bottom right rooms in a tie.
		if(_topDist <= _dist){
			_selection = _i;
		}
	}
	_x = endRoomArray[_selection][0];
	_y = endRoomArray[_selection][1];
			
	if(LOGGING) show_debug_message("Boss room at: " + coords_string(_x, _y));
	generateRoom(_x, _y, ROOMTYPE.BOSS);
	array_delete(endRoomArray, _selection, 1); //Remove the room from the array so it's not used below
	#endregion End Boss Room
	
	#region Item Room
	//Grab a random available end room and make it the item room
	_selection = irandom(array_length(endRoomArray) - 1); //-1 is required as array starts at 0, but the randomizer is inclusive
	_x = endRoomArray[_selection][0];
	_y = endRoomArray[_selection][1];
	generateRoom(_x, _y, ROOMTYPE.ITEM);
	if(LOGGING) show_debug_message("Item room at: " + coords_string(_x, _y));
	array_delete(endRoomArray, _selection, 1); //Remove the room from the array so it's not used below
	#endregion End Item Room
	
	#region Shopp Room
	//Grab a random available end room and make it the shop room
	_selection = irandom(array_length(endRoomArray) - 1); //-1 is required as array starts at 0, but the randomizer is inclusive
	_x = endRoomArray[_selection][0];
	_y = endRoomArray[_selection][1];
	generateRoom(_x, _y, ROOMTYPE.SHOP);
	if(LOGGING) show_debug_message("Shop room at: " + coords_string(_x, _y));
	array_delete(endRoomArray, _selection, 1); //Remove the room from the array so it's not used below
	#endregion End Item Room		
		
}

generateFloorPlan();

//Floor plan is valid
generateEndRooms();

//Validate floor plan
//Ensure spawn room has at least 2 exits




if(LOGGING) show_debug_message("Floor of rooms generated.");



//All rooms should go on the same tilemap

room_pack_reuse_tilemaps = true;
//room_pack_store_tilemaps(global.roomTilesList);


roomMapJson = game_rooms(); //Generated from rooms starting with rm_ex

//Create a list of all rooms

//Find the spawn room location

//Create room type array

//Fill arrays with the keys of each type of room
var _size = ds_map_size(roomMapJson);
var _key = ds_map_find_first(roomMapJson);

spawnRooms = array_create(1, 0);
normalRooms = array_create(1, 0);
emptyRooms = array_create(1, 0);

for(var i = 0; i < _size; i++){
	//Iterate through map, add keys to respective arrays
	if(string_count("spawn", string(_key)) > 0) {
		//Checked key is a spawn room
		array_insert(spawnRooms, 0, _key);
	}
	
	if(string_count("normal", string(_key)) > 0) {
		//Checked key is a normal room
		array_insert(normalRooms, 0, _key);
	}
	
	if(string_count("empty", string(_key)) > 0) {
		//Checked key is a normal room
		array_insert(emptyRooms, 0, _key);
	}
	_key = ds_map_find_next(roomMapJson, _key);
}

//Remove the 0s from the arrays to make sure arrays only contain the keys
array_pop(spawnRooms);
array_pop(normalRooms);
array_pop(emptyRooms);

//Run through level grid and start placing the rooms as they are fit
	for(var i = 0; i < ds_grid_width(levelGrid); i++) {
		for(var j = 0; j < ds_grid_height(levelGrid); j++) {
			var _roomType = levelGrid[# i, j][$ "roomType"];
			
			//Get the DS Map for the current room to generate it, if it's a valid room
			var _randRoom = noone;
			switch(_roomType) {
				case ROOMTYPE.SPAWN:
					_randRoom = string(array_rand_value(spawnRooms));
					break;
				
				case ROOMTYPE.NORMAL:
					_randRoom = string(array_rand_value(normalRooms));
					break;
					
				case ROOMTYPE.BOSS:
					_randRoom = string(array_rand_value(emptyRooms));
					break;		
					
				case ROOMTYPE.ITEM:
					_randRoom = string(array_rand_value(emptyRooms));
					break;					
					
				case ROOMTYPE.SHOP:
					_randRoom = string(array_rand_value(emptyRooms));
					break;										
			}
			
			//If room should exist, create approriate room
			if(_randRoom != noone) {
				room_pack_load_map(roomMapJson[?_randRoom], TILE_SIZE * ROOM_SIZE_WIDTH * i, TILE_SIZE * ROOM_SIZE_HEIGHT * j, room_pack_flag_tiles);				
			}
		}
	}
















