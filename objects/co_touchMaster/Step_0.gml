/// @description Watch for touches
var _loopTimes = 1;
if(instance_exists(co_touchIndicator))
{
	//If screen is already being touched, loop through up to 10 more times
	_loopTimes = 10;
}
//Create an indicator for a touch
for (var i = 0; i < _loopTimes; i += 1) {
	if (device_mouse_check_button_pressed(i, mb_any)) {
		with (instance_create_depth(device_mouse_x(i), device_mouse_y(i), -1000, co_touchIndicator))
		{
			my_touch = i;	
		}
	}
}