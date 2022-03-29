//Variables that can be possibly changed after compile
function init() {
	global.minDistToFire = 40; //Minimum distance to fire	
}
//Macros for the global vars
#macro MIN_DIST_TO_FIRE global.minDistToFire

//How many tiles should the game target to display on screen. 
#macro DESIGN_TILES_WIDE 9 
#macro PLAY_AREA_OFFSET_Y 4 //Sets how far up or down the play area is

//Size of the tiles in game, displayed in pixels.  Sprites do not adjust to tile size
#macro TILE_SIZE 32 
#macro ROOM_SIZE 9 //Was 11 - Want to deprecate this
#macro ROOM_SIZE_WIDTH 9
#macro ROOM_SIZE_HEIGHT 11

//The maximum size a floor of rooms can be
#macro FLOOR_MAX_WIDTH 9
#macro FLOOR_MAX_HEIGHT 9
//How long player has to hold on a tile after dragging a tile
#macro GAME_SPEED 30 //How many steps/frames per second, or FPS

//Control and Movement
#macro DRAG_TIME_MIN 45 //How long player has to hold on a tile after dragging a tile.  Time in steps to calculate dragging
#macro MOVE_LENGTH .05 //Seconds for each movement of ai or player, game speed is 30 fps by default (Value is .5 by default).  Probably want to make this a global var at some point to allow a fast mode

//Spawning config
#macro MIN_SPAWN_TILES 2 //Do not allow spawning within this many tiles

//Config variables
#macro ADMIN 0
#macro LOGGING 0
#macro VISUAL_DEBUG 0
#macro UNLOCK_ALL 0
#macro CONFIGURATION 0
#macro live_enabled 0 // flip this value to 0 to disable GMLive!
#macro ZOOM 0

#macro test:ADMIN 1
#macro test:LOGGING 1
#macro test:VISUAL_DEBUG 1
#macro test:UNLOCK_ALL 1
#macro test:CONFIGURATION 1 
#macro test:live_enabled 1 // flip this value to 0 to disable GMLive!
#macro test:ZOOM 1

