/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_yellow);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_font(fo_debugSmall);
var _bitmaskTile = 0
var _count = 0;
for(var i = iStart + width - 3; i < iStart + width *2 + 3; i++)
{
	//Create all rows in a column before moving to next column
	for(var j = jStart+ height - 10; j < jStart + height*2 + 3; j++)
	{
		//Find what kind of tile is present at X,Y
		//var _coreTile = tilemap_get_at_pixel(_tileID, i + TILE_SIZE / 2, j + TILE_SIZE / 2);

		//var _coordsStr = string(i) + "," + string(j);
		
		//Only check for grid if co_grid exists
		_bitmaskTile = co_tileOverlay.bitmaskGrid[# i, j];
		_count++;
		//draw_text_transformed(TILE_SIZE * i + TILE_SIZE / 2, TILE_SIZE * j - 8 + TILE_SIZE / 2, _coordsStr, 1, 1, 0);
		draw_text_transformed(TILE_SIZE * i + TILE_SIZE / 2, TILE_SIZE * j + 0 + TILE_SIZE / 2, _bitmaskTile, 1, 1, 0);
	}
}
//show_debug_message("Bitmask Tile Draw For Loop ran: " + string(_count)+ " times");