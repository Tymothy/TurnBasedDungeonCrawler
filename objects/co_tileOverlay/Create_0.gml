/// @description Create the tiles

//Get Founcation layer to determine tiles
foundationLayerID = layer_get_id("ts_foundation");
foundationTileID = layer_tilemap_get_id(foundationLayerID);

//Get Floor layer
floorLayerID = layer_get_id("ts_floor");
floorTileID = layer_tilemap_get_id(floorLayerID);

//Get Wall Layer
wallLayerID = layer_get_id("ts_walls");
wallTileID = layer_tilemap_get_id(wallLayerID);

//Set the floor tileset
tilemap_tileset(floorTileID, ts_floor_dungeon_white);

//Set wall tileset
tilemap_tileset(wallTileID, ts_wall_dungeon_white);

//Get floor width/heights in tiles
var _floorWidth = ROOM_SIZE_WIDTH * FLOOR_MAX_WIDTH;
var _floorHeight = ROOM_SIZE_HEIGHT * FLOOR_MAX_HEIGHT;

bitmaskGrid = ds_grid_create(_floorWidth, _floorHeight);


//Iterate through entire floor and set tile
for(var i = 0; i < _floorWidth; i++) {
	for(var j = 0; j < _floorHeight; j++) {
		//var _x = i * TILE_SIZE + (TILE_SIZE / 2);
		//var _y = j * TILE_SIZE + (TILE_SIZE / 2);
		
		
		//Get what kind of tile it is
		var _coreTile = tilemap_get(foundationTileID, i, j);
		
		//Determine what type of tile to set
		switch(_coreTile) {
			case CORETILES.NORMAL:
				//Choose from a set of tiles that assigned to normal floor
				var _tile = choose(1, 15, 16, 63);
				tilemap_set(floorTileID, _tile, i, j);
				break;
			
			case CORETILES.SOLID_WALL:
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
					case 255:
						//This is the full tile
						var _farUp = tilemap_get(foundationTileID, i, j - 2);
						
						//Check to see if two tiles above is empty/solid earth.
						if(_farUp != 0) {
							_farUp = autotile_check_tile(_farUp, _coreTile);
						
							if(_farUp == 1) {
								//Two above is a wall.  Keep as is.	
							}
							if(_farUp == 0) {
								_bitmaskTile = 300;
							}
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
				
				//switch(_bitmaskTile) {
				//	case 0:
				//	//Tile is byitself
				//		_newTileID = 0;
				//		break;
						
				//	case 28:
				//		_newTileID = 13;
				//		break;
						
				//	case 124:
				//		_newTileID = 14;
				//		break;
						
				//	case 112:
				//		_newTileID = 15;
				//		break;
						
				//	case 241:
				//		_newTileID = 26;
				//		break;
						
				//	case 193:
				//		_newTileID = 39;
				//		break;
						
				//	case 199:
				//		_newTileID = 38;
				//		break;
						
				//	case 7:
				//		_newTileID = 37;
				//		break;					
						
				//	case 31:
				//		_newTileID = 25;
				//		break;									

				//	case 16:
				//		_newTileID = 12;
				//		break;			
						
				//	case 17:
				//		_newTileID = 24;
				//		break;
						
				//	case 1:
				//		_newTileID = 48;
				//		break;									
						
				//}
				
				//Testing only
				
				
				
				tilemap_set(wallTileID, _newTileID, i, j);
				
				
				break;
		}
	
	}
}