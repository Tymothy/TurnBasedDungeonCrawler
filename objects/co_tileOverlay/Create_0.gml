/// @description Create the tiles

//Get Founcation layer to determine tiles
foundationLayerID = layer_get_id("ts_foundation");
foundationTileID = layer_tilemap_get_id(foundationLayerID);

//Get Floor layer
floorLayerID = layer_get_id("ts_floor_1");
floorTileID = layer_tilemap_get_id(floorLayerID);

//Get Floor layer 2
floorLayer2ID = layer_get_id("ts_floor_2");
floorTile2ID = layer_tilemap_get_id(floorLayer2ID);

//Get Wall Layer
wallLayerID = layer_get_id("ts_walls");
wallTileID = layer_tilemap_get_id(wallLayerID);

//Get Decor Layer
decorBottomLayerID = layer_get_id("ts_decor_bottom");
decorBottomTileID = layer_tilemap_get_id(decorBottomLayerID);
//Set the floor tilesets
tilemap_tileset(floorTileID, ts_floor_dungeon_gray);
tilemap_tileset(floorTile2ID, ts_floor_dungeon_white);

//Set wall tileset
tilemap_tileset(wallTileID, ts_wall_dungeon_white);

//Get floor width/heights in tiles
var _floorWidth = ROOM_SIZE_WIDTH * FLOOR_MAX_WIDTH;
var _floorHeight = ROOM_SIZE_HEIGHT * FLOOR_MAX_HEIGHT;

bitmaskGrid = ds_grid_create(_floorWidth, _floorHeight);


//First pass iterate through entire floor and set tile
for(var i = 0; i < _floorWidth; i++) {
	for(var j = 0; j < _floorHeight; j++) {

		//Get what kind of tile it is
		var _coreTile = tilemap_get(foundationTileID, i, j);
		
		//Determine what type of tile to set
		switch(_coreTile) {
			case CORETILES.NORMAL:
				//Choose from a set of tiles that assigned to normal floor
				var _tile = choose(1, 15, 16, 63, 63, 63, 63, 63, 63, 63, 63, 63);
				tilemap_set(floorTileID, _tile, i, j);
				break;
				
			case CORETILES.FRONT_WALL:
			
				var _tile = 62;
				tilemap_set(wallTileID, _tile, i, j);
				break;
			
			case CORETILES.OBSTACLE_LOW:		
				var _tile = choose(1, 15, 16, 63, 63, 63, 63, 63, 63, 63, 63, 63);
				tilemap_set(floorTileID, _tile, i, j);
				break;
				
			break;
			
			case CORETILES.SOLID_WALL:
			#region solid wall
				//First determine what kind of wall this is
				//IE, top, bottom, corner
				var _t= tilemap_get(foundationTileID, i, j - 1);
				var _b = tilemap_get(foundationTileID, i, j + 1);
				var _l = tilemap_get(foundationTileID, i - 1, j);
				var _r = tilemap_get(foundationTileID, i + 1, j);
				var _tl = tilemap_get(foundationTileID, i - 1, j - 1);
				var _tr = tilemap_get(foundationTileID, i + 1, j - 1);
				var _bl = tilemap_get(foundationTileID, i - 1, j + 1);
				var _br = tilemap_get(foundationTileID, i + 1, j + 1);
				
				_t = autotile_check_tile(_t, _coreTile);
				_b = autotile_check_tile(_b, _coreTile);
				_l = autotile_check_tile(_l, _coreTile);
				_r = autotile_check_tile(_r, _coreTile);
				_tl = autotile_check_tile(_tl, _coreTile);
				_tr = autotile_check_tile(_tr, _coreTile);
				_bl = autotile_check_tile(_bl, _coreTile);
				_br = autotile_check_tile(_br, _coreTile);
				
				var _bitmaskTile = autotile_bitmask(_t, _b, _l, _r, _tl, _tr, _bl, _br);
				
				

				
				//Special handling for extended tiles
				
				//Tile 255 is the solid wall tile, but we need to chck 2 tiles up to see if it's the top of a room
				switch(_bitmaskTile)
				{
					//case 255:
					//	//This is the full tile
					//	var _farUp = tilemap_get(foundationTileID, i, j - 2);
						
					//	//Check to see if two tiles above is empty/solid earth.
					//	if(_farUp != 0) {
					//		_farUp = autotile_check_tile(_farUp, _coreTile);
						
					//		if(_farUp == 1) {
					//			//Two above is a wall.  Keep as is.	
					//		}
					//		if(_farUp == 0) {
					//			_bitmaskTile = 300;
					//		}
					//	}
					//	break;
					case 119:
						var _downRight = tilemap_get(foundationTileID, i + 1, j + 1);
						if(_downRight == CORETILES.FRONT_WALL) {
								_bitmaskTile = 406;
							
						}
						break;
						
					case 221:
						var _upRight = tilemap_get(foundationTileID, i + 1, j - 1);
						if(_upRight != 0) {
								_bitmaskTile = 407;
							
						}
						break;					
					
					case 17:
						//This is an edge tile.  If this is not connecting to a room, have the dark part
						//Face out.
						
						var _farLeft = tilemap_get(foundationTileID, i - 1, j );
						var _farRight = tilemap_get(foundationTileID, i + 1, j );
						if(_farLeft == 0) {
							//Left side does not have a tile, it's considered solid earth
							_bitmaskTile = 400;
							
						}
						if(_farRight == 0) {
							_bitmaskTile = 401;	
						}
						break;
					
					case 68:
						var _farDown = tilemap_get(foundationTileID, i, j + 2);
						if(_farDown == 0) {
							_bitmaskTile = 402;
							
						}
						break;
						
					case 124:
						var _up = tilemap_get(foundationTileID, i, j - 1);
						if(_up != 0) {
							//Tile above is an actual room
							_bitmaskTile = 403;
							
						}
						
					case 241:
						var _right = tilemap_get(foundationTileID, i + 1, j);
						if(_right == 0) {
							//The right is empty/solid earth
							_bitmaskTile = 404;
						}
						
					case 31:
						var _left = tilemap_get(foundationTileID, i - 1, j);
						if(_left == 0) {
							//Left is solid earth
							_bitmaskTile = 405;
							
						}
						
				}
				ds_grid_set(bitmaskGrid, i, j, _bitmaskTile);				
				//Set tile ID according to bitmask value
				var _newTileID = ds_map_find_value(co_tilesetMapping.wallTileMap, _bitmaskTile);
				
				if is_undefined(_newTileID)
				{
					show_debug_message("Bitmask " + string(_bitmaskTile) + " does not have an assigned tile!");
					_newTileID = 0;
				}
				
				
				
				tilemap_set(wallTileID, _newTileID, i, j);
				
				
				break;
				#endregion
		}
	
	}
}
	
for(var i = 0; i < _floorWidth; i++) {
	for(var j = 0; j < _floorHeight; j++) {
		var _coreTile = tilemap_get(foundationTileID, i, j);
			switch(_coreTile) {
				case CORETILES.SPAWN:
					//Set the spawn pyramid
					//tilemap_set(floorTile2ID, 52, i - 1, j - 1);
					//tilemap_set(floorTile2ID, 53, i , j - 1);
					//tilemap_set(floorTile2ID, 54, i + 1, j - 1);
					//tilemap_set(floorTile2ID, 67, i - 1, j);
					//tilemap_set(floorTile2ID, 63, i, j); //Spawn tile
					//tilemap_set(floorTile2ID, 69, i + 1, j);
					//tilemap_set(floorTile2ID, 82, i - 1, j + 1);
					//tilemap_set(floorTile2ID, 83, i, j + 1);
					//tilemap_set(floorTile2ID, 84, i + 1, j + 1);
					
					tilemap_set(floorTile2ID, 31, i - 1, j - 1);
					tilemap_set(floorTile2ID, 32, i , j - 1);
					tilemap_set(floorTile2ID, 30, i + 1, j - 1);
					tilemap_set(floorTile2ID, 19, i - 1, j);
					tilemap_set(floorTile2ID, 2, i, j); //Spawn tile
					tilemap_set(floorTile2ID, 18, i + 1, j);
					tilemap_set(floorTile2ID, 46, i - 1, j + 1);
					tilemap_set(floorTile2ID, 33, i, j + 1);
					tilemap_set(floorTile2ID, 45, i + 1, j + 1);
					
				break;
				
			case CORETILES.OBSTACLE_LOW:	
				var _t= tilemap_get(foundationTileID, i, j - 1);
				var _b = tilemap_get(foundationTileID, i, j + 1);
				var _l = tilemap_get(foundationTileID, i - 1, j);
				var _r = tilemap_get(foundationTileID, i + 1, j);
				
				_t = autotile_check_tile(_t, _coreTile);
				_b = autotile_check_tile(_b, _coreTile);
				_l = autotile_check_tile(_l, _coreTile);
				_r = autotile_check_tile(_r, _coreTile);
				
				var _bitmaskTile = autotile_bitmask(_t, _b, _l, _r);
				switch(_bitmaskTile)
				{
					
					case 0:
						var _tile = 1;
						break;
						
					case 1:
						var _tile = 42;
						break;
					
					case 4:
						var _tile = 2;
						break;
						
					case 16:
						var _tile = 14;
						break;			
						
					case 17:
						var _tile = 28;
						break;
						
					case 64: 
						var _tile = 4;
						break;
						
					case 68:
						var _tile = 3;
						break;
					
					default:
						var _tile =1;
						break;
				}
				tilemap_set(decorBottomTileID, _tile, i, j);
				ds_grid_set(bitmaskGrid, i, j, _bitmaskTile);		
			break;
			}
			

	}
}