/// @description Draw Minimap


if(minimapRefresh == true) {
	//Refresh the minimap when changes are in
	minimapRefresh = false;
	if(!surface_exists(mmSurf)) {
		mmSurf = surface_create(x2 - x1, y2 - y1);
	}
	
	surface_set_target(mmSurf);
	draw_clear_alpha(c_black, 1); //Set a black background to the minimap surface	
	
	//Draw a standard room for all rooms
	var _frWidth = minimapWidth * TILE_SIZE / FLOOR_MAX_WIDTH;
	var _frHeight = minimapHeight * TILE_SIZE / FLOOR_MAX_HEIGHT;
	
	//Get the height for each cell
	for(var i = 0; i < FLOOR_MAX_WIDTH; i++) {
		for(var j = 0; j < FLOOR_MAX_HEIGHT; j++) {
			//These two lines set a grid
			draw_set_color(c_gray);
			draw_rectangle(i * _frWidth, j * _frHeight, i * _frWidth + _frWidth, j * _frHeight + _frHeight, true);			
			
			//Draw non-empty rooms
			var _roomType = co_roomGen.levelGrid[# i, j][$ "roomType"];
			if(_roomType != ROOMTYPE.NONE) {
				//Room is an open room.  Draw it as such
				draw_set_color(c_ltgray);
				draw_rectangle(i * _frWidth, j * _frHeight, i * _frWidth + _frWidth, j * _frHeight + _frHeight, false);							
			}
		}
	}
	surface_reset_target();
}

//Always draw the surface
draw_surface(mmSurf, x1, y1);