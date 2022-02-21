/*
Constructors for levelGrid in co_roomGen
*/
function floorRoom(_x, _y) constructor {
	//Create a struct for room in the level
	
	//X and Y are the floorCell coords
	x = _x;
	y = _y;

	gridX1 = from_room(x) - floor(ROOM_SIZE / 2);  //Grid top left X
	gridY1 = from_room(y) - floor(ROOM_SIZE / 2);  //Grid top left Y
	gridX2 = gridX1 + ROOM_SIZE - 1;  //Grid bottom right X
	gridY2 = gridY1 + ROOM_SIZE - 1;  //Grid bottom right Y
	
	//Room Type
	roomType = ROOMTYPE.NONE;
	description = "No Room"; //Used to track the name of the room, mainly for debugging
	difficulty = undefined; //Room doesn't exist, so difficulty is undefined
	cleared = false; //Whether the room has been cleared already
	minimap = true; //Whether the room should show on the minimap or not  Set to false for live
	endRoom = false; //Whether the room is an end room
	distanceToSpawn = 0; //How many tiles to spawn room, including self
}

function spawnRoom (_x, _y) : floorRoom(_x, _y) constructor {
	roomType = ROOMTYPE.SPAWN;
	description = "Spawn Room";
	difficulty = DIFFICULTY.PEACEFUL; //Room is spawn room, we don't want enemies here
}

function normalRoom (_x, _y) : floorRoom(_x, _y) constructor {
	roomType = ROOMTYPE.NORMAL;
	description = "Normal Room";
	difficulty = choose(DIFFICULTY.EASY, DIFFICULTY.MEDIUM, DIFFICULTY.HARD); //Choose a random difficulty
}

function setEndRoom (_x, _y) : floorRoom(_x, _y) constructor {
	endRoom = true;
	show_debug_message("End room at " + coords_string(_x, _y));
}