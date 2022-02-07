/*
Constructors for levelGrid in co_fillRooms
*/
function floorRoom(_x, _y) constructor {
	//Create a struct for room in the level
	
	//X and Y are the floorCell coords
	x = _x;
	y = _y;
	
	//Room Type
	roomType = ROOMTYPE.NONE;
	description = "No Room"; //Used to track the name of the room, mainly for debugging
	difficulty = DIFFICULTY.NONE; //Room doesn't exist, so difficulty is none
	cleared = false; //Whether the room has been cleared already
	minimap = true; //Whether the room should show on the minimap or not  Set to false for live
}

function spawnRoom (_x, _y) constructor {
	x = _x;
	y = _y;
	
	roomType = ROOMTYPE.SPAWN;
	description = "Spawn Room";
	difficulty = DIFFICULTY.PEACEFUL; //Room is spawn room, we don't want enemies here
}

function normalRoom (_x, _y) constructor {
	x = _x;
	y = _y;
	
	roomType = ROOMTYPE.NORMAL;
	description = "Normal Room";
	difficulty = choose(DIFFICULTY.EASY, DIFFICULTY.MEDIUM, DIFFICULTY.HARD); //Choose a random difficulty
}