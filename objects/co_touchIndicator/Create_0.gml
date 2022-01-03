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
alarm[0] = 1;
//Create the touchGridSelect object.  Grid should only allow one touch at a time  
//if(instance_exists(co_touchGridSelect))
//{
//	instance_destroy(co_touchGridSelect)	
//}

//var _obj = instance_create_depth(x, y, -1001, co_touchGridSelect);
//_obj.my_touch = my_touch;
////Buttons

//Grid