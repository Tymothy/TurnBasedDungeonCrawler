/// @description Update on move, destroy on release

//Update position

x = device_mouse_x(my_touch);
y = device_mouse_y(my_touch);

//Destroy on release
if (device_mouse_check_button_released(my_touch, mb_any))
{
	instance_destroy();
}