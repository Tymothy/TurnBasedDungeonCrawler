/// @description Create a blank minimap
event_inherited();
//Figure out the top left and bottom right coords of minimap
refresh = false; //Used to track when to update the minimap, we want to create first so start as true
width = DESIGN_TILES_WIDE; //Width in tiles
height = PLAY_AREA_OFFSET_Y;

height2 = ROOM_SIZE_HEIGHT + PLAY_AREA_OFFSET_Y;

waitForLevelGen = true;

xOff = 0;
yOff = 0;

x1 = xOff * TILE_SIZE;
y1 = yOff * TILE_SIZE;
x2 = (xOff + width) * TILE_SIZE;
y2 = (yOff + height) * TILE_SIZE;

y3 = height2 * TILE_SIZE;
y4 = y3 + 3000; //Draw far off the bottom of the screen
surf = surface_create(WIDTH, HEIGHT);
