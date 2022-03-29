/// @description Show Player Collision
draw_set_alpha(.25); //Lower opacity of collision grid overlay
//Only check for grid if co_grid exists
if(instance_exists(co_grid))
{
	//Iterate through all tiles and determine if collision is true or not in ds grid
	for(var i = 0; i < room_height / TILE_SIZE; i++)
	{
		for(var j = 0; j < room_width / TILE_SIZE; j++)
		{
			var _structValue = co_grid.tileGrid[# i, j][$ "_collidePlayer"];//Find if the player can collide with current tile
			//var _structValue = co_grid.tileGrid[# i, j][$ "_aiSpawnable"];//Find if the player can collide with current tile
			switch(_structValue)
			{
				case false:
					draw_set_color(c_lime);			
				break;
			
				case true:
					draw_set_color(c_red);
				break;
			}

			draw_rectangle(i * TILE_SIZE, j * TILE_SIZE, i * TILE_SIZE + TILE_SIZE - 1, j * TILE_SIZE + TILE_SIZE - 1, false); //Draw the tile
			//draw_text_transformed(TILE_SIZE * i + TILE_SIZE / 2, TILE_SIZE * j - 8 + TILE_SIZE / 2, string(_collide), 1, 1, 0);
		}
	}
}
draw_set_alpha(1); //Reset opacity back to default