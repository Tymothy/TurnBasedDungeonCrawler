/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function floorRoom(_x, _y, _id) constructor {
	//Create a struct for room in the level
	
	//X and Y are the floorCell coords
	x = _x;
	y = _y;
	id = _id;
	//Sets where doors are valid at
	doorUp = false; 
	doorRight = false; 
	doorDown = false;
	doorLeft = false;
	
	//Room Type
	roomType = ROOMTYPE.NONE;
	_description = "No Room"; //Used to track the name of the room, mainly for debugging	
}