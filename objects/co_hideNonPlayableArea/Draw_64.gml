/// @description Draw Cover Area


if(refresh == true && waitForLevelGen == false) {
	var _gw = global.gui_width;
	var _gh = global.gui_height;
	//Refresh the minimap when changes are in
	refresh = false;
	if(!surface_exists(surf)) {
		create_surface();
	}
	
	surface_set_target(surf);
	draw_clear_alpha(c_black, 1); //Set a black background to the minimap surface	
	
	////Draw the background
	draw_set_alpha(.5);
	draw_set_color(c_black);	
	
	//Set alpha to .7 for debugging the playable area
	//draw_set_alpha(.7);
	draw_rectangle(0, 0, _gw, _gh, false);	
	//draw_set_alpha(1);
	//Cut out the play area from the shader
	var _x1 = global.guiPlayableX1;
	var _y1 = global.guiPlayableY1;
	var _x2 = global.guiPlayableX2;
	var _y2 = global.guiPlayableY2;
	
	
	gpu_set_blendmode(bm_subtract);
	draw_rectangle(_x1, _y1, _x2, _y2, false);
	gpu_set_blendmode(bm_normal);
	
	surface_reset_target();
}

//Always draw the surface
if(surface_exists(surf)){
	var _vx = camera_get_view_x(view_camera[0]);
	var _vy = camera_get_view_y(view_camera[0]);
	draw_surface(surf, 0, 0);
	//draw_surface(surf, x1, y1);
}