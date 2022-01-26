/// @description Create floor of rooms

//Configure loader
//global.roomTilesList = ds_list_create();
//All rooms should go on the same tilemap
var _xOff = 1;
var _yOff = 7; //How many tiles down should the game area be
room_pack_reuse_tilemaps = true;
//room_pack_store_tilemaps(global.roomTilesList);

//Create the spawn room first


if(LOGGING) show_debug_message("Attempting to create spawn room");
var _dir = filename_dir("Game Rooms\\Spawn\\spawn_1.json");
if(LOGGING) show_debug_message("Directory: " + string(_dir));

var _spawnResult = room_pack_load_file("Game Rooms\\Spawn\\spawn_1.json", TILE_SIZE * _xOff, TILE_SIZE * _yOff, room_pack_flag_tiles);
if(LOGGING && _spawnResult) show_debug_message("Spawn room created successfully");
if(LOGGING && !_spawnResult) show_debug_message("ERROR: SPAWN ROOM FAILED CREATION");


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
	
	var _floorStruct = new floorRoom(0,0); //Init the floor struct
	for(var i = 0; i < FLOOR_MAX_WIDTH; i++) {
		for(var j = 0; j < FLOOR_MAX_HEIGHT; j++) {
			_floorStruct = new floorRoom(i, j);
			ds_grid_set(levelGrid, i, j, _floorStruct);
		}
	}	
	//Generate spawn room in the middle
	var _spawnX = floor(FLOOR_MAX_WIDTH / 2);
	var _spawnY = floor(FLOOR_MAX_HEIGHT / 2);
	_floorStruct = new spawnRoom(_spawnX, _spawnY);
	
	ds_grid_set(levelGrid, _floorStruct.x, _floorStruct.y, _floorStruct);
	//Blank slate of rooms generated.
	goalRooms = goal_rooms();	
	goalRooms = 5;//Hard set to test
	var _createdRooms = 1;	//Starts at 1 as spawn room is already created.


	
	//Set inital room to search from at spawn
	var _x = _spawnX;
	var _y = _spawnY;
	
	for(var i = 0; i < 1000 && _createdRooms < goalRooms; i++) {
		//Randomize the start direction
		var _dir = irandom(3);  //0 = East, goes counter clockwise
		var _startX = _x; //Holds the room we started at
		var _startY = _y;
		//
		switch(_dir) {
			case 0:
			//Search East
				_x++;
			break;
			
			case 1:
			//Search South
				_y++;
			break;
			
			case 2:
			//Search West
				_x--;
			break;
			
			case 3:
			//Search North
				_y--;
			break;			
		}
		
		var _result = generateARoom(_x, _y);
		//See if room has already been filled
		if(_result == true) {
			//Room was generated successfully at x and y coords	
			//Move the pointer to the created room
			_floorStruct = new normalRoom(_x, _y);
			ds_grid_set(levelGrid, _floorStruct.x, _floorStruct.y, _floorStruct);
			_createdRooms++;
			_startX = _x;
			_startY = _y;
		}
		else {
			//Room was not generated successfully at x and y coords
			//Set values back to start to try again
			_x = _startX;
			_y = _startY;
		}
		
		
	}	
}

generateARoom = function(_x, _y) {
				
		//Check has already been generated. 
		var _roomType = levelGrid[# _x, _y][$ "roomType"];
		if(_roomType != ROOMTYPE.NONE) {
			return false;
		}		
	
		//Check if the room already has 2 neighbors
		//TODO: Implement checking to ensure out of bounds is not being checked
		var _neighbors = 0;
		var _tempRoom = levelGrid[# _x - 1, _y][$ "roomType"];
		if(_tempRoom != ROOMTYPE.NONE) {
			//Room is a filled cell
			_neighbors++
		}
		var _tempRoom = levelGrid[# _x + 1, _y][$ "roomType"];
		if(_tempRoom != ROOMTYPE.NONE) {
			//Room is a filled cell
			_neighbors++
		}
		var _tempRoom = levelGrid[# _x, _y - 1][$ "roomType"];
		if(_tempRoom != ROOMTYPE.NONE) {
			//Room is a filled cell
			_neighbors++
		}
		var _tempRoom = levelGrid[# _x, _y + 1][$ "roomType"];
		if(_tempRoom != ROOMTYPE.NONE) {
			//Room is a filled cell
			_neighbors++
		}
		
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
generateFloorPlan();

if(LOGGING) show_debug_message("Floor of rooms generated.");
