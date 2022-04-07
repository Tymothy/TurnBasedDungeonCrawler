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
	for(var i = 0; i < room_height / TILE_SIZE + 1; i++)
	{
		//Create all rows in a column before moving to next column
		for(var j = 0; j < room_width / TILE_SIZE + 1; j++)
		{
			//Find what kind of tile is present at X,Y
			var _coreTile = tilemap_get_at_pixel(_tileID, i * TILE_SIZE + TILE_SIZE / 2, j * TILE_SIZE + TILE_SIZE / 2);
			
			//Needed otherwise Gamemaker will crash.  This is reassinged in the switch statement below
			tileStruct = new OutOfPlay(i, j, _coreTile);
			//Generate the struct for the tile and put into ds grid
			switch(_coreTile) //TODO: Can be improved by having each case reference a master list
			{
				case CORETILES.NORMAL: //Normal floor - light gray
					tileStruct = new NormalFloor(i, j, _coreTile);
					break;
				
				case 2:
					
					break;
				
				case CORETILES.DOOR_FLOOR: //Door Floor - light blue
					
					break;
				
				case 8: //Spawn point - lime green
					tileStruct = new NormalFloor(i, j, _coreTile);
					break;
				
				case 11: //Solid Wall - dark gray
					tileStruct = new SolidWall(i, j, _coreTile);
					break;
				
				case CORETILES.DOOR_WALL:
					tileStruct = new DoorWall(i, j, _coreTile);
					break;
				
				default:
					tileStruct = new OutOfPlay(i, j, _coreTile);
					break;
			}
			ds_grid_set(tileGrid, i, j, tileStruct);
			
			
		}
	
	}
	if(LOGGING) show_debug_message("Grid generation complete");
}

rangeLineGrid = ds_grid_create(ROOM_SIZE_WIDTH, ROOM_SIZE_HEIGHT);
rangeDiagGrid = ds_grid_create(ROOM_SIZE_WIDTH, ROOM_SIZE_HEIGHT);

//Generate collision grids
mpGrid_collidePlayer = mp_grid_create(0, 0, ceil(room_width / TILE_SIZE), ceil(room_height / TILE_SIZE), TILE_SIZE, TILE_SIZE);
mpGrid_collideOther = mp_grid_create(0, 0, ceil(room_width / TILE_SIZE), ceil(room_height / TILE_SIZE), TILE_SIZE, TILE_SIZE);
mpGrid_collideProjectile = mp_grid_create(0, 0, ceil(room_width / TILE_SIZE), ceil(room_height / TILE_SIZE), TILE_SIZE, TILE_SIZE);
mpGrid_entity = mp_grid_create(0, 0, ceil(room_width / TILE_SIZE), ceil(room_height / TILE_SIZE), TILE_SIZE, TILE_SIZE);
mpGrid_noCollision = mp_grid_create(0, 0, ceil(room_width / TILE_SIZE), ceil(room_height / TILE_SIZE), TILE_SIZE, TILE_SIZE);


//Fill mp grids with proper collision
mp_forbid_cells(co_grid.mpGrid_collidePlayer, "_collidePlayer");
mp_forbid_cells(co_grid.mpGrid_collideOther, "_collideOther");
mp_forbid_cells(co_grid.mpGrid_collideProjectile, "_collideProjectile");
mp_forbid_cells(co_grid.mpGrid_entity, "_entityInTile");

open_door = function(_x, _y) {
	tileStruct = new DoorOpen(_x, _y);
	ds_grid_set(tileGrid, _x, _y, tileStruct);
}

refreshRangeGrids = function(){
	var _gridPlayerX = to_grid(ob_player.x);
	var _gridPlayerY = to_grid(ob_player.y);
	var _offX = co_gameManager.leftGridX;
	var _offY = co_gameManager.topGridY;
	
	
	for(var i = 0; i < ROOM_SIZE_WIDTH; i++) {
		for(var j = 0; j < ROOM_SIZE_HEIGHT; j++) {
			var _line = check_range_line_attack(_gridPlayerX, _gridPlayerY, self, i + _offX, j + _offY, ROOM_SIZE_HEIGHT);
			var _diag = check_range_diag_attack(_gridPlayerX, _gridPlayerY, self, i + _offX, j + _offY, ROOM_SIZE_HEIGHT)
			
			if(_line != false){
				var _dist = abs(point_distance(_gridPlayerX, _gridPlayerY, i + _offX, j + _offY));
				ds_grid_set(rangeLineGrid, i, j, _dist);
			}
			else {
				ds_grid_set(rangeLineGrid, i, j, 0);	
			}
			
			if(_diag != false) {
				var _dist = abs(_gridPlayerX - i - _offX);
				ds_grid_set(rangeDiagGrid, i, j, _dist);				
			}
			else {
				ds_grid_set(rangeDiagGrid, i, j, 0);	
			}
		}
	}
	show_debug_message("Refreshed Range Grids");
}
