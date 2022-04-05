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
		slide : false,
		ranged_projectile : false,
		ranged_wall : false,
	}
	
	//Find the current grid position
	gridX = to_grid(obj.x);
	gridY = to_grid(obj.y);	
	
	//Check if direct attack is possible

	/*
	Direct Attack
	Attacking entity starts turn near target and uses their turn to attack a single target
	*/
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

function check_direct_attack(gridX, gridY, obj = self) {
	/// @desc Given grid coords, returns whether direct attack is possible by given object.  If no object is given, return self
	/// @desc If attack is possible, returns the entity.
	/// @arg gridX
	/// @arg gridY
	/// @arg object(optional)	
	
	/*
		Direct attack is where the attacking entity starts turn near target and uses their turn to attack
		a single target.
	*/
	var _entityInTile = co_grid.tileGrid[# gridX, gridY][$ "_entityInTile"];
	
	if(_entityInTile == false) {
		//No entity in tile, attack not possible.
		return false;	
	}
	
	//Check range
	var _distX = abs(gridX - to_grid(obj.x));
	var _distY = abs(gridY - to_grid(obj.y));
	
	if(_distX > self.property.meleeAttackRange || _distY > self.property.meleeAttackRange) {
		//Entity is outside range	
		return false;
	}
	
	var _ent = check_entity(gridX, gridY);	
	
	if(_ent.property.attackable == true && _ent != self.id) {
		//Target entity is attackable.  Return entity
		//Prevents self attacks
		show_debug_message("Direct attack entity " + string(_ent));
		
		return _ent;
	}
	
	//If entity is not attackable, return false
	return false;
}