/// @description Update on move, destroy on release

//Update position

x = device_mouse_x(my_touch);
y = device_mouse_y(my_touch);
set_touch_grid(my_touch, id, x, y);

//Destroy on release
if (device_mouse_check_button_released(my_touch, mb_any))
{
	remove_from_touch_grid(my_touch); //Sets the associated grid to -1s
	instance_destroy();
}