/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function floorRoom(_x, _y) constructor {
	//Create a struct for room in the level
	
	//X and Y are the floorCell coords
	x = _x;
	y = _y;
	//Sets where doors are valid at
	doorUp = false; 
	doorRight = false; 
	doorDown = false;
	doorLeft = false;
	
	//Room Type
	roomType = ROOMTYPE.NONE;
	description = "No Room"; //Used to track the name of the room, mainly for debugging	
}

function spawnRoom (_x, _y) constructor {
	x = _x;
	y = _y;
	
	roomType = ROOMTYPE.SPAWN;
	description = "Spawn Room";
}

function normalRoom (_x, _y) constructor {
	x = _x;
	y = _y;
	
	roomType = ROOMTYPE.NORMAL;
	description = "Normal Room";
}