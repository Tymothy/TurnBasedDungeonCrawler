/// @description Create floor of rooms

//Configure loader
//global.roomTilesList = ds_list_create();
//All rooms should go on the same tilemap
var _xOff = 1;
var _yOff = 1;
room_pack_reuse_tilemaps = true;
//room_pack_store_tilemaps(global.roomTilesList);

//Create the spawn room first


if(LOGGING) show_debug_message("Attempting to create spawn room");
var _dir = filename_dir("Game Rooms\\Spawn\\spawn_1.json");
if(LOGGING) show_debug_message("Directory: " + string(_dir));

var _spawnResult = room_pack_load_file("Game Rooms\\Spawn\\spawn_1.json", TILE_SIZE * _xOff, TILE_SIZE * _yOff, room_pack_flag_tiles);
if(LOGGING && _spawnResult) show_debug_message("Spawn room created successfully");
if(LOGGING && !_spawnResult) show_debug_message("ERROR: SPAWN ROOM FAILED CREATION");



