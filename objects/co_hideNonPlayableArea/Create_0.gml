/// @description Create a blank minimap
event_inherited();

//Hold the surface coords of the camera so we can draw to screen
create = function() {
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
	draw_clear_alpha(c_black, 0); //Clear the surface just in case
	
	//Get coords of where to cut out play area
	

	//Figure out the top left and bottom right coords of minimap
	refresh = false; //Used to track when to update the minimap, we want to create first so start as true
	width = DESIGN_TILES_WIDE; //Width in tiles of play area
	height = PLAY_AREA_OFFSET_Y;

	height2 = ROOM_SIZE_HEIGHT + PLAY_AREA_OFFSET_Y;

	waitForLevelGen = true;

	xOff = 0;
	yOff = 0;

	x1 = xOff * TILE_SIZE;
	y1 = yOff * TILE_SIZE;
	x2 = (xOff + width) * TILE_SIZE;
	y2 = (yOff + height) * TILE_SIZE;

	y3 = height2 * TILE_SIZE;
	y4 = y3 + 3000; //Draw far off the bottom of the screen
	//surf = surface_create(global.gui_width, global.gui_height);
	alarm[0] = 30;
}
create();