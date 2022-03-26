/// @description Create the references

wallTileMap = ds_map_create();
//First number is the bitmask value
//Second number is reference to tileID within the tileset
ds_map_add(wallTileMap, 4, 1);
ds_map_add(wallTileMap, 68, 2);
ds_map_add(wallTileMap, 64, 3);

ds_map_add(wallTileMap, 16, 12);
ds_map_add(wallTileMap, 28, 13);
ds_map_add(wallTileMap, 124, 14);
ds_map_add(wallTileMap, 112, 15);

ds_map_add(wallTileMap, 17, 24);
ds_map_add(wallTileMap, 31, 25);
ds_map_add(wallTileMap, 241, 27);

ds_map_add(wallTileMap, 1, 36);

ds_map_add(wallTileMap, 7, 85);
ds_map_add(wallTileMap, 199, 86);
ds_map_add(wallTileMap, 193, 87);

ds_map_add(wallTileMap, 255, 62);
//ds_map_add(wallTileMap, 
//ds_map_add(wallTileMap, 
//ds_map_add(wallTileMap, 
//ds_map_add(wallTileMap, 
//ds_map_add(wallTileMap, 
//ds_map_add(wallTileMap, 
//ds_map_add(wallTileMap, 
//ds_map_add(wallTileMap, 
show_debug_message("wallTileMap created");