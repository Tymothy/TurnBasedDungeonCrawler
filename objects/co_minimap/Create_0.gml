/// @description Create a blank minimap
event_inherited();
//Figure out the top left and bottom right coords of minimap

minimapWidth = 4; //Width in tiles
minimapHeight = 4;

xOff = 1;
yOff = 1;

x1 = xOff * TILE_SIZE;
y1 = yOff * TILE_SIZE;
x2 = (xOff + minimapWidth) * TILE_SIZE;
y2 = (yOff + minimapHeight) * TILE_SIZE;