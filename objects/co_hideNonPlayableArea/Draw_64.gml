/// @description Draw Minimap


if(refresh == true && waitForLevelGen == false) {
	//Refresh the minimap when changes are in
	refresh = false;
	if(!surface_exists(surf)) {
		surf = surface_create(x2 - x1, y2 - y1);
	}
	
	surface_set_target(surf);
	draw_clear_alpha(c_black, 1); //Set a black background to the minimap surface	
	
	//Draw the background
	draw_set_color(c_black);	

	draw_rectangle(x1, y1, x2, y2, false);	
	
	surface_reset_target();
}

//Always draw the surface
if(surface_exists(surf)){
	draw_surface(surf, x1, y1);
}