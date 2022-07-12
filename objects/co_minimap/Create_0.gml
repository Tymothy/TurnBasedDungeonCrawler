/// @description Create a blank minimap
event_inherited();

create_surface();
//Figure out the top left and bottom right coords of minimap
var _gw = global.gui_width;
var _gh = global.gui_height;
minimapRefresh = false; //Used to track when to update the minimap, we want to create first so start as true
minimapWidth = 4; //Width in tiles
minimapHeight = 4;

gridLineWidth = 1;

waitForLevelGen = true;

xOff = 1;
yOff = 1;

//Use _gh to use the smaller of the values for a square minimap.
x1 = _gh * .03;
y1 = _gh * .03;
x2 = _gh * .2;
y2 = _gh * .2;

//mmSurf = surface_create(minimapWidth * TILE_SIZE* RESOLUTION_SCALE, minimapHeight * TILE_SIZE* RESOLUTION_SCALE);

refreshMinimap = function() {
	minimapRefresh = true;
}
