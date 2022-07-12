/// @description Init GUI
//rows = ceil(HEIGHT / TILE_SIZE);
//cols = ceil(WIDTH / TILE_SIZE);
gw = global.gui_width;
gh = global.gui_height;
//Create an anchoring system

create_surface = function() {
	var _vx = camera_get_view_x(view_camera[0]);
	var _vy = camera_get_view_y(view_camera[0]);

	var _dw = display_get_gui_width();
	var _dh = display_get_gui_height();
	
	var _power = 1;
	while(power(2, _power) < _dw || power(2, _power) < _dh) {
		//Creates the surfaces in lowest power of 2 possible, while still being big enough for the screen.
		_power ++;
	}
	//Surfaces should be created as a power of 2 to increase compatibility
	//show_message("Surface size: " + string(power(2, _power)));
	surf = surface_create(power(2, _power), power(2, _power));
	draw_clear_alpha(c_black, 1); //Clear the surface just in case
	
	//Get coords of where to cut out play area
	

	//Figure out the top left and bottom right coords of minimap
	refresh = true; //Used to track when to update the minimap, we want to create first so start as true
	waitForLevelGen = true;

}