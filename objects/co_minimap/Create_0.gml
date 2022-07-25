/// @description Create a blank minimap
event_inherited();

create_surface();
//Figure out the top left and bottom right coords of minimap

minimapRefresh = false; //Used to track when to update the minimap, we want to create first so start as true
minimapWidth = 4; //Width in tiles
minimapHeight = 4;

waitForLevelGen = true;

//Use _gh to use the smaller of the values for a square minimap.
x1 = gh * .03;
y1 = gh * .03;
x2 = gh * .3;
y2 = gh * .3;
gridLineWidth = gw / NATIVE_WIDTH; //Lines are 
//mmSurf = surface_create(minimapWidth * TILE_SIZE* RESOLUTION_SCALE, minimapHeight * TILE_SIZE* RESOLUTION_SCALE);

refreshMinimap = function() {
	minimapRefresh = true;
}
