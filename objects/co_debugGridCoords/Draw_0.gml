/// @description Show grid coords
for(var i = 0; i < room_height / TILE_SIZE; i++)
{
	//Create all rows in a column before moving to next column
	for(var j = 0; j < room_width / TILE_SIZE; j++)
	{
		//Find what kind of tile is present at X,Y
		//var _coreTile = tilemap_get_at_pixel(_tileID, i + TILE_SIZE / 2, j + TILE_SIZE / 2);
		draw_set_color(c_black);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_center);
		draw_set_font(fo_debug);
		var _coreTile = tilemap_get_at_pixel(tileID, i + TILE_SIZE / 2, j + TILE_SIZE / 2);
		var _coordsStr = string(i) + "," + string(j);
		var _coreTileStr = string(_coreTile);
		draw_text_transformed(TILE_SIZE * i + TILE_SIZE / 2, TILE_SIZE * j - 8 + TILE_SIZE / 2, _coordsStr, 1, 1, 0);
		draw_text_transformed(TILE_SIZE * i + TILE_SIZE / 2, TILE_SIZE * j + 0 + TILE_SIZE / 2, _coreTileStr, 1, 1, 0);
	}
}