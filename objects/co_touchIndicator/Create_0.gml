/// @description Init
my_touch = -1;

//Grab coords of first touch
xStart = x;
yStart = y;

//Always grab the grid coords that's touched
xGridCoord = floor(xStart / TILE_SIZE);
yGridCoord = floor(yStart / TILE_SIZE);

//if(LOGGING) show_debug_message("Clicked: " + string(xStart) + ", " + string(yStart));
if(LOGGING) show_debug_message("Grid coord: " + string(xGridCoord) + ", " + string(yGridCoord));
//TODO: Check hierarchy of clickable objects

//Buttons

//Grid