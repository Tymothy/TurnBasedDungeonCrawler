/// @description Move the random tile

rows = ceil(HEIGHT / TILE_SIZE);
cols = ceil(WIDTH / TILE_SIZE);

random_col = TILE_SIZE * irandom(cols - 1);
random_row = TILE_SIZE * irandom(rows - 1);
show_debug_message("Row: " + string(random_row));
show_debug_message("Col: " + string(random_col));
show_debug_message("Rows: " + string(rows));
show_debug_message("Cols: " + string(cols));
alarm[0] = 60;