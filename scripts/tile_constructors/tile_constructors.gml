
/*
Based upon the ts_foundation tilemap, generate structs for every tile.
This will be used generate spawns, collision, etc.

*/
function Tile(_x, _y, _id) constructor {
	//Create a struct for every tile in the room
	
	//X and Y are the grid coords, not room coords
	x = _x;
	y = _y;
	id = _id;
	_collidePlayer = false; //Prevents player from pathing
	_collideOther = false; //Prevents enemies from pathing
	_collideProjectile = false; //Used for pits, water, lava, small objects like chests.  Allows projectiles over		
	_description = "Default tile"; //Used to track the name of the tile, mainly for debugging
	
}

function NormalFloor(_x, _y, _id) : Tile() constructor {
	x = _x;
	y = _y;
	id = _id;
	_collidePlayer = false; //Prevents player from pathing
	_collideOther = false; //Prevents enemies from pathing
	_collideProjectile = false; //Used for pits, water, lava, small objects like chests.  Allows projectiles over		
	_description = "Normal Floor";
}

function SolidWall(_x, _y, _id) : Tile() constructor {
	x = _x;
	y = _y;
	id = _id;
	_collidePlayer = true; //Prevents player from pathing
	_collideOther = true; //Prevents enemies from pathing
	_collideProjectile = true; //Used for pits, water, lava, small objects like chests.  Allows projectiles over		
	_description = "Solid Wall";
}