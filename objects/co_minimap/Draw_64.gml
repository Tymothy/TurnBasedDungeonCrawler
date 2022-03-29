/// @description Draw Minimap


if(minimapRefresh == true && waitForLevelGen == false) {
	//Refresh the minimap when changes are in
	minimapRefresh = false;
	if(!surface_exists(mmSurf)) {
		mmSurf = surface_create(minimapWidth * TILE_SIZE, minimapHeight * TILE_SIZE);
	}
	
	surface_set_target(mmSurf);
	//draw_clear_alpha(c_black, 1); //Set a black background to the minimap surface	
	
	//TODO: Sizing isn't very accurate
	var _frWidth = ceil(minimapWidth * floor(TILE_SIZE / FLOOR_MAX_WIDTH));
	var _frHeight = ceil(minimapHeight * floor(TILE_SIZE / FLOOR_MAX_HEIGHT));

	//Get the height for each cell
	for(var i = 0; i < FLOOR_MAX_WIDTH; i++) {
		for(var j = 0; j < FLOOR_MAX_HEIGHT; j++) {
			//Draw non-empty rooms
			var _roomType = co_roomGen.levelGrid[# i, j][$ "roomType"];
			switch(_roomType) {
				case ROOMTYPE.SPAWN:
					draw_set_color(c_lime);						
				break;
				
				case ROOMTYPE.NORMAL:
					draw_set_color(c_ltgray);				
				break;
				
				case ROOMTYPE.NONE:
					draw_set_color(c_black);
				break;
			}
			//Draw the grid square with approriate color
			draw_rectangle(i * _frWidth, j * _frHeight, i * _frWidth + _frWidth, j * _frHeight + _frHeight, false);							
			
		}
	}
	
	//Draw the grid lines over the minimap
	draw_set_color(c_gray);	
	for(var i = 0; i <= FLOOR_MAX_WIDTH; i++) {
		draw_rectangle(i * _frWidth, 0, i * _frWidth + gridLineWidth, minimapHeight * TILE_SIZE, false);			
	}
	for(var j = 0; j <= FLOOR_MAX_HEIGHT; j++) {
		draw_rectangle(0, j * _frHeight, minimapWidth * TILE_SIZE, j * _frHeight + gridLineWidth, false);	

	}


	
	surface_reset_target();
}

//Always draw the surface
if(surface_exists(mmSurf)){
	draw_surface(mmSurf, x1, y1);
}