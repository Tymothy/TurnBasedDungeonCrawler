/// @description Create the references

wallTileMap = ds_map_create();
//First number is the bitmask value
//Second number is reference to tileID within the tileset
ds_map_add(wallTileMap, 4, 1);

ds_map_add(wallTileMap, 64, 3);

ds_map_add(wallTileMap, 16, 12);

ds_map_add(wallTileMap, 28, 16);
ds_map_add(wallTileMap, 247, 16);
ds_map_add(wallTileMap, 23, 16);
ds_map_add(wallTileMap, 116, 16);
ds_map_add(wallTileMap, 20, 16);

ds_map_add(wallTileMap, 112, 17);
ds_map_add(wallTileMap, 80, 17);
ds_map_add(wallTileMap, 221, 17);
ds_map_add(wallTileMap, 209, 17);
ds_map_add(wallTileMap, 223, 17);
ds_map_add(wallTileMap, 92, 17);

ds_map_add(wallTileMap, 17, 24);

ds_map_add(wallTileMap, 112, 25);


ds_map_add(wallTileMap, 31, 25);
ds_map_add(wallTileMap, 241, 27);


ds_map_add(wallTileMap, 5, 28);
ds_map_add(wallTileMap, 197, 28);

ds_map_add(wallTileMap, 253, 28);
ds_map_add(wallTileMap, 29, 28);
ds_map_add(wallTileMap, 65, 29);
ds_map_add(wallTileMap, 71, 29);
ds_map_add(wallTileMap, 113, 29);
ds_map_add(wallTileMap, 119, 29);
ds_map_add(wallTileMap, 127, 29);

ds_map_add(wallTileMap, 1, 36);

ds_map_add(wallTileMap, 124, 38);
ds_map_add(wallTileMap, 68, 38);
ds_map_add(wallTileMap, 199, 38);

ds_map_add(wallTileMap, 7, 85);

ds_map_add(wallTileMap, 193, 87);

ds_map_add(wallTileMap, 255, 62);

//Special tiles
ds_map_add(wallTileMap, 300, 38);

ds_map_add(wallTileMap, 400, 27);
ds_map_add(wallTileMap, 401, 25);
ds_map_add(wallTileMap, 402, 14);
ds_map_add(wallTileMap, 403, 14);
ds_map_add(wallTileMap, 404, 25);
ds_map_add(wallTileMap, 405, 27);
ds_map_add(wallTileMap, 406, 16);
ds_map_add(wallTileMap, 407, 28);
//ds_map_add(wallTileMap, 
//ds_map_add(wallTileMap, 
//ds_map_add(wallTileMap, 
show_debug_message("wallTileMap created");