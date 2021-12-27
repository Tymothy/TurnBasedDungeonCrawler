/// @description Handle resolution and scaling
var _designHeight = TILE_SIZE * DESIGN_TILES_WIDE;

set_resolution (_designHeight, false, true,  false);

room_goto(rm_game);