/// @description Create collision grid
//Check for the ts_foundation layer, this contains the blueprint of tiles

//var _layID = ds_list_find_value(global.roomTilesList, 0);
var _layID = layer_get_id("ts_foundation");
var _tileID = layer_tilemap_get_id(_layID);
if(_tileID == -1) show_debug_message("ERROR: TILEMAP NOT FOUND");
//Create grid if tilemap is found
else
{
	//Create DS Grid to store the structs of the tiles
	var _gridW = room_width / TILE_SIZE;
	var _gridH = room_height / TILE_SIZE;
	tileGrid = ds_grid_create(_gridW + 1, _gridH + 1);
	
	//Create the columns
	for(var i = 0; i < room_height / TILE_SIZE; i++)
	{
		//Create all rows in a column before moving to next column
		for(var j = 0; j < room_width / TILE_SIZE; j++)
		{
			//Find what kind of tile is present at X,Y
			var _coreTile = tilemap_get_at_pixel(_tileID, i * TILE_SIZE + TILE_SIZE / 2, j * TILE_SIZE + TILE_SIZE / 2);
			
			//Needed otherwise Gamemaker will crash.  This is reassinged in the switch statement below
			tileStruct = new SolidWall(i, j, _coreTile);
			//Generate the struct for the tile and put into ds grid
			switch(_coreTile) //TODO: Can be improved by having each case reference a master list
			{
				case CORETILES.NORMAL: //Normal floor - light gray
					tileStruct = new NormalFloor(i, j, _coreTile)
				break;
				
				case 2:
					
				break;
				
				case CORETILES.DOOR_FLOOR: //Door Floor - light blue
					
				break;
				
				case 8: //Spawn point - lime green
					tileStruct = new NormalFloor(i, j, _coreTile)
				break;
				
				case 11: //Solid Wall - dark gray
					tileStruct = new SolidWall(i, j, _coreTile)
				break;
				
				case CORETILES.DOOR_WALL:
					tileStruct = new DoorWall(i, j, _coreTile)
				break;
			}
			ds_grid_set(tileGrid, i, j, tileStruct);
			
			
		}
	
	}
	if(LOGGING) show_debug_message("Grid generation complete");
}