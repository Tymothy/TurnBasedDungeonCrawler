/// @description Draw grid in room


var str;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fo_debugSmall);

for (var i = 0; i < rows; i++)
{
	for (var j = 0; j < cols; j++)
	{
		
		draw_sprite(s_tile, 0, TILE_SIZE * j, TILE_SIZE * i);	
		
		if i == 0 and j == 0 then str = "1";
		else if j == 0 and i > 0 then str = string(i + 1);
		else if i == 0 and j > 0 then str = string(j + 1); else str = "";
		draw_text_transformed(TILE_SIZE * j + TILE_SIZE / 2, TILE_SIZE * i + TILE_SIZE / 2, str, 1, 1, 0);
		//draw_text_transformed(TILE_SIZE * j, TILE_SIZE * i, string(j+1) + "," + string(i+1), 3, 3, 0);
		
	}
}

if i == rows and j == cols then frame = false;





