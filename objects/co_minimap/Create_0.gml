/// @description Create a blank minimap
event_inherited();
//Figure out the top left and bottom right coords of minimap
minimapRefresh = false; //Used to track when to update the minimap, we want to create first so start as true
minimapWidth = 4; //Width in tiles
minimapHeight = 4;

gridLineWidth = 1;

waitForLevelGen = true;

xOff = 1;
yOff = 1;

x1 = xOff * TILE_SIZE;
y1 = yOff * TILE_SIZE;
x2 = (xOff + minimapWidth) * TILE_SIZE;
y2 = (yOff + minimapHeight) * TILE_SIZE;

mmSurf = surface_create(x2 - x1, y2 - y1);
