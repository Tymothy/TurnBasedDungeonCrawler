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

//Fill the grid with "empty" rooms (Solid earth/no rooms)
var _floorStruct = new floorRoom(0,0); //Init the floor struct
for(var i = 0; i < FLOOR_MAX_WIDTH; i++) {
	for(var j = 0; j < FLOOR_MAX_HEIGHT; j++) {
		_floorStruct = new floorRoom(i, j);
		ds_grid_set(levelGrid, i, j, _floorStruct);
	}
}

_floorStruct = new spawnRoom(floor(FLOOR_MAX_WIDTH / 2), floor(FLOOR_MAX_HEIGHT / 2));
ds_grid_set(levelGrid, _floorStruct.x, _floorStruct.y, _floorStruct);
//Blank slate of rooms generated.


if(LOGGING) show_debug_message("Floor of rooms generated.");
