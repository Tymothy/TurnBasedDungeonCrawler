/// @description Init
//Create a ds grid that will hold locations of all touches on screen

//When an indicator is created, store it's ID, my_touchVar, x, and y
touchGrid = ds_grid_create(11, 7);
ds_grid_clear(touchGrid,-1);