/// @description Draw Minimap


if(refresh == true && waitForLevelGen == false) {
	var _gw = global.gui_width;
	var _gh = global.gui_height;
	//Refresh the minimap when changes are in
	refresh = false;
	if(!surface_exists(surf)) {
		create();
	}
	
	surface_set_target(surf);
	//draw_clear_alpha(c_black, 1); //Set a black background to the minimap surface	
	
	////Draw the background
	//draw_set_color(c_black);	
	//draw_rectangle(0, 0, _gw, _gh, false);	
	
	////Cut out the play area from the shader
	//gpu_set_blendmode(bm_subtract);
	//draw_rectangle(_gw / 4, _gh / 4, _gw - _gw / 4, _gh - _gh / 4, false);
	//gpu_set_blendmode(bm_normal);
	
	surface_reset_target();
}

//Always draw the surface
if(surface_exists(surf)){
	var _vx = camera_get_view_x(view_camera[0]);
	var _vy = camera_get_view_y(view_camera[0]);
	draw_surface(surf, 0, 0);
	//draw_surface(surf, x1, y1);
}