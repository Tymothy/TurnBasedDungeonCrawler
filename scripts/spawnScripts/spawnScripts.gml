/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function spawn_player(_x = -1, _y = -1){
	//If we provide values, spawn player at those values.  Otherwise, place on spawn tile
	if(_x != -1) {
		instance_create_layer(from_grid(_x), from_grid(_y), "la_player", ob_player);
	}
	//We are not loading, so just spawn the player
	else {
	
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
						//if(LOGGING) show_debug_message("Player spawned at grid coords: " + string(i) + ", " + string(j));
						return 1;
					}
				}
			}
			if(LOGGING) show_debug_message("ERROR: NO SPAWNABLE TILE EXISTS, CANNOT SPAWN PLAYER");
			return -1;

		}
		else 
		{
		// Grid does not exist, thus cannot spawn player
			if(LOGGING) show_debug_message("ERROR: NO GRID EXISTS, CANNOT SPAWN PLAYER");
			return -1;
		}
	}
}

function spawn_ai(_obj, _spawnNum, _roomX, _roomY) {

	//Spawn AI within the given room

	//Get center of room to work spawn points
	//var _centerGridX = from_room_x(_roomX);
	//var _centerGridY = from_room_y(_roomY);
	
	//Get top left of room to determine X1 and Y1
	var _x1 =  co_roomGen.levelGrid[# _roomX, _roomY][$"gridX1"];
	var _y1 =  co_roomGen.levelGrid[# _roomX, _roomY][$"gridY1"];
	var _x2 =  co_roomGen.levelGrid[# _roomX, _roomY][$"gridX2"];
	var _y2 =  co_roomGen.levelGrid[# _roomX, _roomY][$"gridY2"];
	

	var _maxSpawnAttempts = 500;
	var _spawns = 0;

		for(var i = 0; i < _maxSpawnAttempts && _spawns < _spawnNum; i++)
		{
			//Grab a random grid x and y to attempt spawn at
			var _randX = irandom(ROOM_SIZE_WIDTH - 1) + _x1;
			var _randY = irandom(ROOM_SIZE_HEIGHT - 1) + _y1;
			
			//Start _spawnValid as true, and set to false if it breaks any rules
			var _spawnValid = true;
			
			//check if cell is valid for spawning
			var _spawnable = co_grid.tileGrid[# _randX, _randY][$ "_aiSpawnable"];
			if(_spawnable == false) _spawnValid = false;
			
			//If grid is a valid spawn tile, check distance from player
			if(_spawnValid == true) {
				var _distX = gridX_dist_to_player(_randX);
				var _distY = gridY_dist_to_player(_randY);
				
				if(_distX <= MIN_SPAWN_TILES && _distY <= MIN_SPAWN_TILES) {
					_spawnValid = false;
				}
			}
			
			//If spawn point is still valid, spawn ai.
			if(_spawnValid == true) {
				//instance_create_layer(from_grid(_randX), from_grid(_randY), "la_ai", _obj);
				spawn_entity(_obj, _randX, _randY);
				//if(LOGGING) show_debug_message("Spawned AI " + string(_obj.property.name) + " at " + coords_string(_randX, _randY) + " after " + string(i) + " attempts");
				_spawns++;
			}
				
			if(LOGGING && i == _maxSpawnAttempts -1) show_debug_message("Max spawn attempts reached, stopping spawn attempts");	

		}

		//var _gridW = ds_grid_width(co_grid.tileGrid);
		//var _gridH = ds_grid_height(co_grid.tileGrid);
		//var _maxSpawnAttempts = 500;
		//var _spawns = 0;
			
		////Try spawning up to 500 times
		////TODO: This could be made a bit better by not repicking spawn points, but likely doesn't
		////Matter that much.
		//for(var i = 0; i < _maxSpawnAttempts && _spawns < _spawnNum; i++)
		//{
		//	//Grab a random grid x and y to attempt spawn at
		//	var _randX = irandom(_gridW - 1);
		//	var _randY = irandom(_gridH - 1);
			
		//	//Start _spawnValid as true, and set to false if it breaks any rules
		//	var _spawnValid = true;
			
		//	//check if cell is valid for spawning
		//	var _spawnable = co_grid.tileGrid[# _randX, _randY][$ "_aiSpawnable"];
		//	if(_spawnable == false) _spawnValid = false;
			
		//	//If grid is a valid spawn tile, check distance from player
		//	if(_spawnValid == true) {
		//		var _distX = gridX_dist_to_player(_randX);
		//		var _distY = gridY_dist_to_player(_randY);
				
		//		if(_distX <= MIN_SPAWN_TILES && _distY <= MIN_SPAWN_TILES) {
		//			_spawnValid = false;
		//		}
		//	}
			
		//	//If spawn point is still valid, spawn ai.
		//	if(_spawnValid == true) {
		//		instance_create_layer(from_grid(_randX), from_grid(_randY), "la_ai", _obj);
		//		if(LOGGING) show_debug_message("Spawned AI " + string(_obj.property.name) + " at " + coords_string(_randX, _randY) + " after " + string(i) + " attempts");
		//		_spawns++;
		//	}
				
		//	if(LOGGING && i == _maxSpawnAttempts -1) show_debug_message("Max spawn attempts reached, stopping spawn attempts");	
		//}
		
}
	
function spawn_entity (_entity, _gridX, _gridY) {
	if(_entity == ob_player) {
		spawn_player(_gridX, _gridY);
		
	}
	else {
	instance_create_layer(from_grid(_gridX), from_grid(_gridY), "la_ai", _entity);
	}
}