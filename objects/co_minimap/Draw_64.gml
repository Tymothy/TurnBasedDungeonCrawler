/// @description Draw Minimap


if(minimapRefresh == true && waitForLevelGen == false) {
	//Refresh the minimap when changes are in
	show_debug_message("Refreshing/Building Minimap");
	minimapRefresh = false;
	if(!surface_exists(surf)) {
		create_surface();
	}
	
	surface_set_target(surf);
	//draw_clear_alpha(c_black, 1); //Set a black background to the minimap surface	
	
	//TODO: Sizing isn't very accurate
	var _frWidth = ceil((x2 - x1) / FLOOR_MAX_WIDTH);
	var _frHeight = ceil((y2 - y1) / FLOOR_MAX_HEIGHT);

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
				
				default:
				//A room not on list, like a unique
					draw_set_color(c_purple);
					break;
			}

			if( i == co_gameManager.currentRoomX && j == co_gameManager.currentRoomY) {
				draw_set_color(c_orange);
			}	
					
			//Draw the grid square with approriate color
			draw_rectangle(i * _frWidth, j * _frHeight, i * _frWidth + _frWidth, j * _frHeight + _frHeight, false);							

		}
	}
	
	//Draw the grid lines over the minimap
	draw_set_color(c_gray);	
	for(var i = 0; i <= FLOOR_MAX_WIDTH; i++) {
		draw_rectangle(i * _frWidth, 0, i * _frWidth + gridLineWidth, _frHeight * FLOOR_MAX_HEIGHT, false);			
	}
	for(var j = 0; j <= FLOOR_MAX_HEIGHT; j++) {
		draw_rectangle(0, j * _frHeight, _frWidth * FLOOR_MAX_WIDTH, j * _frHeight + gridLineWidth, false);	

	}


	
	surface_reset_target();
}

//Always draw the surface
if(surface_exists(surf)){
	draw_surface(surf, x1, y1);
}