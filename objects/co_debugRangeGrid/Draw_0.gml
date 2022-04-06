/// @description 
var _roomXOffset = ROOM_SIZE_WIDTH * co_gameManager.currentRoomX * TILE_SIZE;
var _roomYOffset = ROOM_SIZE_HEIGHT * co_gameManager.currentRoomY * TILE_SIZE;

draw_set_color(c_yellow);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_font(fo_debugSmall);
var _value = 0
var _count = 0;
for(var i = 0; i < ROOM_SIZE_WIDTH; i++)
{
	//Create all rows in a column before moving to next column
	for(var j = 0; j < ROOM_SIZE_HEIGHT; j++)
	{
		//Find what kind of tile is present at X,Y
		//var _coreTile = tilemap_get_at_pixel(_tileID, i + TILE_SIZE / 2, j + TILE_SIZE / 2);

		//var _coordsStr = string(i) + "," + string(j);
		
		//Only check for grid if co_grid exists
		_value = co_grid.rangeDiagGrid[# i, j];
		if(_value <= 0) {
			_value = co_grid.rangeLineGrid[# i, j];	
		}
		_count++;
		//draw_text_transformed(TILE_SIZE * i + TILE_SIZE / 2, TILE_SIZE * j - 8 + TILE_SIZE / 2, _coordsStr, 1, 1, 0);
		draw_text_transformed(_roomXOffset + TILE_SIZE * i + TILE_SIZE / 2, _roomYOffset + TILE_SIZE * j + 0 + TILE_SIZE / 2, _value, 1, 1, 0);
	}
}
