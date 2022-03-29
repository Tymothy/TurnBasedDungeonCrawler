/// @description Create a blank minimap
event_inherited();
//Figure out the top left and bottom right coords of minimap
refresh = false; //Used to track when to update the minimap, we want to create first so start as true
width = DESIGN_TILES_WIDE; //Width in tiles
height = 5;

waitForLevelGen = true;

xOff = 0;
yOff = 0;

x1 = xOff * TILE_SIZE;
y1 = yOff * TILE_SIZE;
x2 = (xOff + width) * TILE_SIZE;
y2 = (yOff + height) * TILE_SIZE;

surf = surface_create(x2 - x1, y2 - y1);
