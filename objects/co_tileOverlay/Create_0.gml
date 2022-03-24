/// @description Create the tiles

//Get Founcation layer to determine tiles
foundationLayerID = layer_get_id("ts_foundation");
foundationTileID = layer_tilemap_get_id(foundationLayerID);

//Get Floor layer
floorLayerID = layer_get_id("ts_floor");
floorTileID = layer_tilemap_get_id(floorLayerID);

//Set the floor tileset
tilemap_tileset(floorTileID, ts_floor_dungeon_white);

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
				
				break;
		}
	
	}
}