/// @description Print mouse GUI Coords to console on click


var _gx = device_mouse_x_to_gui(0);
var _gy = device_mouse_y_to_gui(0);

show_debug_message(coords_string(_gx, _gy));