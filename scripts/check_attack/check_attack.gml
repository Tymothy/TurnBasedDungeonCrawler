/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function check_valid_attacks(obj = self){
	/// @desc Returns what attacks are valid from current position, given an object.  If no object is given, return self
	/// @arg object(optional)

	validAttacks = {
		direct : false,
		lunge : false,
		ranged_projectile : false,
		ranged_wall : false,
	}
	
	//Find the current grid position
	gridX = to_grid(obj.x);
	gridY = to_grid(obj.y);	
	
	//Check if direct attack is possible
	//Check the 9 grid squares around player for an entity other than self
	//TODO: Ensure co_grid is tracking entities properly
	direct = false;
	for(var i = gridX - 1; i <= gridX + 1; i++) {
		for(var j = gridY - 1; j <= gridY + 1; j++) {
			//This will cycle through the 9 squares of the object
			if(gridX != i && gridY != j) {
				//Skip the square the obejct is currently on.	
			}
			else {
				//Check if entity is in the tile
				direct = co_grid.tileGrid[# i, j][$ "_entityInTile"];
			}
			//Set direct attacking to true if at least one entity present
			if(direct == true) validAttacks.direct = true;
			
		}
		
	}

	return validAttacks;

}