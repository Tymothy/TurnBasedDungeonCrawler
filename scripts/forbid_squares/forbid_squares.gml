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

function mp_clear_entity(_grid) {
	//Mark cell as empty for collision logic.
	var _x = to_grid(self.x);
	var _y = to_grid(self.y);
	mp_grid_clear_cell(_grid, _x, _y);
	with(co_grid) {
		co_grid.tileGrid[# _x, _y][$ "_entityInTile"] = false;
	}
}

function mp_add_entity(_grid) {
	//Mark cell as empty for collision logic.
	var _x = to_grid(self.x);
	var _y = to_grid(self.y);
	mp_grid_add_cell(_grid, _x, _y);
	with(co_grid) {
		co_grid.tileGrid[# _x, _y][$ "_entityInTile"] = true;
	}
}