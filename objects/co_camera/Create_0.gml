/// @description Create the camera
//set_camera(0, 0, global.MonitorW, global.MonitorH);



view_camera[0] = camera_create_view(0, 0, NATIVE_WIDTH, NATIVE_HEIGHT);


//camera_set_view_size(camID, NATIVE_WIDTH * RESOLUTION_SCALE, NATIVE_HEIGHT * RESOLUTION_SCALE);



set_fullscreen = function() {
	global.MonitorW = display_get_width();
	global.MonitorH = display_get_height();
	global.Xoffset = (global.MonitorW - NATIVE_WIDTH) / 2;
	global.Yoffset = (global.MonitorH - NATIVE_HEIGHT) / 2;
	application_surface_draw_enable(false);
	set_gui_size(global.MonitorW); 

	var _scale = 1;

	//Checks how high we can scale the game without going over the montior limits
	while(global.MonitorH >= NATIVE_WIDTH * _scale && global.MonitorW >= NATIVE_HEIGHT * _scale) {
		_scale++;	
	}

	RESOLUTION_SCALE = _scale;
	
	window_set_fullscreen(true);
	var base_w = NATIVE_WIDTH;
	var base_h = NATIVE_HEIGHT;
	var max_w = display_get_width();
	var max_h = display_get_height();
	var aspect = display_get_width() / display_get_height();
	if (max_w < max_h)
		{
		// portait
		    var VIEW_WIDTH = min(base_w, max_w);
		var VIEW_HEIGHT = VIEW_WIDTH / aspect;
		}
	else
		{
		// landscape
		var VIEW_HEIGHT = min(base_h, max_h);
		var VIEW_WIDTH = VIEW_HEIGHT * aspect;
		}
	camera_set_view_size(view_camera[0], floor(VIEW_WIDTH), floor(VIEW_HEIGHT) );
	view_wport[0] = max_w;
	view_hport[0] = max_h;
	surface_resize(application_surface, view_wport[0], view_hport[0]);

	camID = view_camera[0];
	camWidth = camera_get_view_width(camID);
	camHeight = camera_get_view_height(camID);

	targX = x;
	targY = y;

	xOffset = camWidth/2 - (ROOM_SIZE_WIDTH * TILE_SIZE / 2);
	yOffset = camHeight/2  - (ROOM_SIZE_HEIGHT * TILE_SIZE / 2);

}
	
set_window = function(_scale) {
	window_set_fullscreen(false);
	window_set_size(NATIVE_WIDTH * _scale, NATIVE_HEIGHT * _scale);
	
}
//TODO: Update this so set_fullscreen is not required to update variables for set_window
set_fullscreen();

//TODO: Polish resolution settings
set_window(3);

