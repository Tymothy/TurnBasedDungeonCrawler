/// @description Draw GUI squares
// You can write your code in this editor


// ui on the last col tile 
draw_sprite(s_tile_ui, 0, TILE_SIZE * (cols - 1), 0);
// ui on the last row tile
draw_sprite(s_tile_ui, 0, 0, TILE_SIZE * (rows - 1));


//ui on random tile
draw_sprite(s_tile_ui_2, 0, random_col, random_row);





