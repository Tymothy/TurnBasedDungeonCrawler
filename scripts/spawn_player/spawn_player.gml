/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function spawn_player(){
	//Loop through grid and find the spawn tile.  Spawn player on spawn tile.
	if(instance_exists(co_grid)) 
	{
		//Grid exists, find the spawn tile
		for(var i = 0; i < room_height / TILE_SIZE; i++)
		{
			//Create all rows in a column before moving to next column
			for(var j = 0; j < room_width / TILE_SIZE; j++)
			{
				var _spawnTile = co_grid.tileGrid[# i, j][$ "id"];//Show the id of the ds grid
				if(_spawnTile == CORETILES.SPAWN)
				{
					instance_create_layer(i * TILE_SIZE + TILE_SIZE / 2, j * TILE_SIZE + TILE_SIZE / 2, "la_player", ob_player);	
					if(LOGGING) show_debug_message("Player spawned at grid coords: " + string(i) + ", " + string(j));
					return 1;
				}
			}
		}
		return -1;
		if(LOGGING) show_debug_message("ERROR: NO SPAWNABLE TILE EXISTS, CANNOT SPAWN PLAYER");
	}
	else 
	{
	// Grid does not exist, thus cannot spawn player
		if(LOGGING) show_debug_message("ERROR: NO GRID EXISTS, CANNOT SPAWN PLAYER");
	}
	
	
	
	
}