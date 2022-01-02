/// @description Move the random tile

rows = ceil(HEIGHT / TILE_SIZE);
cols = ceil(WIDTH / TILE_SIZE);

random_col = TILE_SIZE * irandom(cols - 1);
random_row = TILE_SIZE * irandom(rows - 1);

alarm[0] = 60;