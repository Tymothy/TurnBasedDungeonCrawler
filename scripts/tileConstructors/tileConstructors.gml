
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
	_entityInTile = false;
	_aiSpawnable = false;
	_description = "Default tile"; //Used to track the name of the tile, mainly for debugging	
	_door = false;
}

function NormalFloor(_x, _y, _id) : Tile() constructor {
	x = _x;
	y = _y;
	id = _id;
	_collidePlayer = false; //Prevents player from pathing
	_collideOther = false; //Prevents enemies from pathing
	_collideProjectile = false; //Used for pits, water, lava, small objects like chests.  Allows projectiles over	
	_entityInTile = false;
	_aiSpawnable = true;
	_description = "Normal Floor";
}

function SolidWall(_x, _y, _id) : Tile() constructor {
	x = _x;
	y = _y;
	id = _id;
	_collidePlayer = true; //Prevents player from pathing
	_collideOther = true; //Prevents enemies from pathing
	_collideProjectile = true; //Used for pits, water, lava, small objects like chests.  Allows projectiles over		
	_entityInTile = false;
	_aiSpawnable = false;
	_description = "Solid Wall";
}

function OutOfPlay(_x, _y, _id) : Tile() constructor {
	x = _x;
	y = _y;
	id = _id;
	_collidePlayer = true; //Prevents player from pathing
	_collideOther = true; //Prevents enemies from pathing
	_collideProjectile = true; //Used for pits, water, lava, small objects like chests.  Allows projectiles over		
	_entityInTile = false;
	_aiSpawnable = false;
	_description = "Solid Wall";
}

function DoorWall(_x, _y, _id) : Tile() constructor {
	x = _x;
	y = _y;
	id = _id;
	_collidePlayer = true; //Prevents player from pathing
	_collideOther = true; //Prevents enemies from pathing
	_collideProjectile = true; //Used for pits, water, lava, small objects like chests.  Allows projectiles over		
	_entityInTile = false;
	_aiSpawnable = false;
	_description = "Door Wall";
}

function DoorOpen(_x, _y) : Tile() constructor {
	x = _x;
	y = _y;
	_collidePlayer = false; //Prevents player from pathing
	_collideOther = true; //Prevents enemies from pathing
	_collideProjectile = true; //Used for pits, water, lava, small objects like chests.  Allows projectiles over		
	_entityInTile = false;
	_aiSpawnable = false;
	_description = "Open Door";
	
	_door = true;
}

function set_aiSpawnable(_x, _y, _id, _value) : Tile() constructor {
	x = _x;
	y = _y;
	id = _id;
	_aiSpawnable = _value;	
}