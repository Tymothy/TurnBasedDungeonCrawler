/// @description Init
//Create a struct that will hold locations of all touches on screen

//When an indicator is created, store it's ID, my_touchVar, x, and y
touchGrid = ds_grid_create(11, 4);
ds_grid_clear(touchGrid,-1);