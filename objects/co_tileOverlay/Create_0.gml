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
var _floorWidth = ROOM_SIZE * FLOOR_MAX_WIDTH;
var _floorHeight = ROOM_SIZE * FLOOR_MAX_HEIGHT;

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
				var _tileTop = tilemap_get(foundationTileID, i, j - 1);
				var _tileDown = tilemap_get(foundationTileID, i, j + 1);
				var _tileLeft = tilemap_get(foundationTileID, i - 1, j);
				var _tileRight = tilemap_get(foundationTileID, i + 1, j);
				
				var _newTileID =
					(_tileTop ? 1:0) +
					(_tileDown ? 2:0) +
					(_tileLeft ? 4:0) +
					(_tileRight ? 8:0)
				
				/*
				0 = No walls around
				1 = Up
				2 = Down
				3 = Top, down
				4 = Left
				5 = Left, Up
				6 = Left, Down
				7 = Left, Up, Down
				8 = Right
				9 = Right, Up
				10 = Right, Down
				11 = Right, Up, Down
				12 = Right, Left
				13 = Right, Left, Up
				14 = Right, Left, Down
				15 = Right, Left, Up, Down
				*/
				
				//Testing only
				_newTileID = 50; 
				
				tilemap_set(wallTileID, _newTileID, i, j);
				
				
				break;
		}
	
	}
}