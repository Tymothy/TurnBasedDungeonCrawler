/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function set_touch_grid(_my_touch, _id, _x, _y){
		/*
		Columns are each individual touch instance
		Rows track the data of each instance
		ds_grid_set(touchGrid, col, my_touch, val);

		col
		0 = my_touch
		1 = ID of the instance
		2 = x
		3 = y
		*/

	
	ds_grid_set(co_touchMaster.touchGrid, _my_touch, 0, _my_touch);
	ds_grid_set(co_touchMaster.touchGrid, _my_touch, 1, _id);
	ds_grid_set(co_touchMaster.touchGrid, _my_touch, 2, _x);
	ds_grid_set(co_touchMaster.touchGrid, _my_touch, 3, _y);
}

function remove_from_touch_grid(_my_touch, _id, _x, _y){
	//Clear the touch instance from grid
	ds_grid_set(co_touchMaster.touchGrid, _my_touch, 0, -1);
	ds_grid_set(co_touchMaster.touchGrid, _my_touch, 1, -1);
	ds_grid_set(co_touchMaster.touchGrid, _my_touch, 2, -1);
	ds_grid_set(co_touchMaster.touchGrid, _my_touch, 3, -1);

}