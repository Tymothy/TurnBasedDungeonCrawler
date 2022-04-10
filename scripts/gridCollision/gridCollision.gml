/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function mp_forbid_cells(_grid, _type){
	//Iterate through all tiles and determine if collision is true or not in ds grid
	for(var i = 0; i < room_height / TILE_SIZE; i++)
	{
		for(var j = 0; j < room_width / TILE_SIZE; j++)
		{
			var _collide = co_grid.tileGrid[# i, j][$ _type];//Find the value of the collision
			switch(_collide)
			{
				//If true, forbid cell
				case true:
					mp_grid_add_cell(_grid, i, j)
				break;
				
				case false:
					mp_grid_clear_cell(_grid, i, j)		
				break;

			}

			
		}
	}

}

function mp_clear_entity(inst = self.id) {
	//Mark cell as empty for collision logic.
	var _x = to_grid(inst.x);
	var _y = to_grid(inst.y);
	mp_grid_clear_cell(co_grid.mpGrid_entity, _x, _y);
	with(co_grid) {
		co_grid.tileGrid[# _x, _y][$ "_entityInTile"] = false;
	}
}

function mp_add_entity() {
	//Mark cell as empty for collision logic.
	var _x = to_grid(self.x);
	var _y = to_grid(self.y);
	mp_grid_add_cell(co_grid.mpGrid_entity, _x, _y);
	with(co_grid) {
		co_grid.tileGrid[# _x, _y][$ "_entityInTile"] = true;
	}
}

function mp_clear_entity_player_collision(inst = self.id) {
	var _x = to_grid(inst.x);
	var _y = to_grid(inst.y);
	mp_grid_clear_cell(co_grid.mpGrid_collidePlayer, _x, _y);
	with(co_grid) {
		co_grid.tileGrid[# _x, _y][$ "_collidePlayer"] = false;
	}	
}

function mp_add_entity_player_collision(inst = self.id) {
	var _x = to_grid(inst.x);
	var _y = to_grid(inst.y);
	mp_grid_clear_cell(co_grid.mpGrid_collidePlayer, _x, _y);
	with(co_grid) {
		co_grid.tileGrid[# _x, _y][$ "_collidePlayer"] = true;
	}	
}

function check_entity(_gridX, _gridY) {
	/// @desc Checks for entity at given grid coords.  If entity exists, return entity.  Otherwise return false.
	/// @arg gridX
	/// @arg gridY
		if(mp_grid_get_cell(co_grid.mpGrid_entity, _gridX, _gridY) == -1) {
			//Grid is occupied, return object
			var _inst = instance_position(from_grid(_gridX), from_grid(_gridY), co_trueStateActor);
			return _inst;
		}
		else {
			return false;
		}

}

function check_grid(_grid, _x, _y, _structValue = ""){
	//Returns the value of the room
	
	//Check to see if value would be out of bounds.  If so, don't check it
	if(_x <= -1 || _y <= -1 || _x >= ds_grid_width(_grid) || _y >= ds_grid_height(_grid)) {
		//Trying to check out of bounds, return noone
		return noone;
	}
	
	if(_structValue == "") var _ret = _grid[# _x, _y];
	else var _ret = _grid[# _x, _y][$string(_structValue)];
	
	return _ret;
}