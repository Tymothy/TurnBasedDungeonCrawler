/// @description Create a blank minimap
event_inherited();
//Figure out the top left and bottom right coords of minimap
minimapRefresh = false; //Used to track when to update the minimap, we want to create first so start as true
minimapWidth = 2; //Width in tiles
minimapHeight = 2;

gridLineWidth = 1;

waitForLevelGen = true;

xOff = 1;
yOff = 1;

x1 = xOff * TILE_SIZE * RESOLUTION_SCALE;
y1 = yOff * TILE_SIZE* RESOLUTION_SCALE;
x2 = (xOff + minimapWidth) * TILE_SIZE * RESOLUTION_SCALE;
y2 = (yOff + minimapHeight) * TILE_SIZE * RESOLUTION_SCALE;

mmSurf = surface_create(minimapWidth * TILE_SIZE* RESOLUTION_SCALE, minimapHeight * TILE_SIZE* RESOLUTION_SCALE);

refreshMinimap = function() {
	minimapRefresh = true;
}
