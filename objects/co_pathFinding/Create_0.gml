/// @description Init
startTile = -1;
goalTile = -1;



/*
if(instance_exists(co_grid))
{
	//Iterate through all tiles and determine if collision is true or not in ds grid
	for(var i = 0; i < room_height / TILE_SIZE; i++)
	{
		for(var j = 0; j < room_width / TILE_SIZE; j++)
		{
			var _collide = co_grid.tileGrid[# i, j][$ "_collidePlayer"];//Find if the player can collide with current tile
			switch(_collide)
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
*/