function state_ai_slime_idle(_event) {
	//So, here's your basic state template
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//This code will run once when the state is brand new.
			truestate_clear_history();
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//Enemy waits it's turn before being allowed to go
			
			//When AI turn starts, determine movement
			if(aiActive == true) {
				//Determine what state to take
				truestate_switch(STATES.MOVE);
			}
			
			
		}break;
	
		//DRAW---------------------------------------
		case TRUESTATE_DRAW:
		{
			//And this code will be exeucted during the draw event
		}break;
	
		//FINAL---------------------------------------
		case TRUESTATE_FINAL:
		{
			//This code will run once right before switching to a new state.
		}break;
	}
}
	
function state_ai_slime_move(_event) {
	//So, here's your basic state template
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			
			mp_clear_entity(); //Clears self from entity grid
			
			targX = -1;
			targY = -1;
			twerpTimer = 0;
			entity = noone;
			
			pathToPlayer = path_add();
			
			calcPath = function() {
				mp_grid_path(self.attributes.collisionGrid, pathToPlayer, x, y, attributes.targetObject.x, attributes.targetObject.y, true);
				//TODO: Track collision with other enemies to prevent them from overlapping
				
				//Enemies can only move one tile at a time, per turn
				var _xx = path_get_point_x(pathToPlayer, 1);
				var _yy = path_get_point_y(pathToPlayer, 1);
				var dir = point_direction(x, y, _xx, _yy);
							
				//Calc grid point to move to
				targX = to_grid(_xx);
				targY = to_grid(_yy);
				gridTargX = targX;
				gridTargY = targY;
				//Get the room coords back.  This is need to ensure x and y are
				//On the actual grid coords, and not slightly off
				targX = from_grid(targX);
				targY = from_grid(targY);
				
				//Check entity grid, if filled, add to collision grid and then repath.
				//After repathing, clean up the adds
				entity = check_entity(gridTargX, gridTargY);

			}
			calcPath();
			// if(mp_grid_get_cell(co_grid.mpGrid_entity, gridTargX, gridTargY) == -1) {
			
			if(entity != false) {	
				//Target cell is occupied, unable to move there.
				//Since we cannot move to target cell, set targets to current
				//Coords so enemy does not move.
				//targX = x;
				//targY = y;
				//TODO: Improve future logic to try to reroute
				
				var i = 0;
				do {
					//Cycle through 3 iterations of pathing to see if a proper path can be found
					mp_grid_add_cell(self.attributes.collisionGrid, gridTargX, gridTargY);
					tempEntityX[i] = gridTargX;
					tempEntityY[i] = gridTargY;
					calcPath();
					i++;
					if(entity == false) {
						show_debug_message("Found a path around");
						}
				}
				until (entity == false || i == 4)
				
				if(i == 4) {
					//Path not found, set targets to current position
					targX = x;
					targY = y;					
				}
				
				//Clean up to not leave ghost collision
				for(var i = 0; i < array_length(tempEntityX); i++) {
					mp_grid_clear_cell(self.attributes.collisionGrid, tempEntityX[i], tempEntityY[i]);
				}
				
			}
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			
			x = twerp(TwerpType.inout_cubic, x, targX, twerpTimer / global.moveTime);
			y = twerp(TwerpType.inout_cubic, y, targY, twerpTimer / global.moveTime);
			twerpTimer += d(1);
			
			if(x = targX && y = targY) {
				//Movement complete
				aiActive = false;
				truestate_switch(STATES.IDLE);
			}
		}break;
	
		//DRAW---------------------------------------
		case TRUESTATE_DRAW:
		{
			draw_path(pathToPlayer, x, y, false);
		}break;
	
		//FINAL---------------------------------------
		case TRUESTATE_FINAL:
		{
			mp_add_entity();  //Adds self to entity grid
			path_delete(pathToPlayer);
		}break;
	}
}

function state_ai_slime_flee(_event) {
	//So, here's your basic state template
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//This code will run once when the state is brand new.
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//This code will be executed during the step event.
		}break;
	
		//DRAW---------------------------------------
		case TRUESTATE_DRAW:
		{
			//And this code will be exeucted during the draw event
		}break;
	
		//FINAL---------------------------------------
		case TRUESTATE_FINAL:
		{
			//This code will run once right before switching to a new state.
		}break;
	}
}

function state_ai_slime_attack(_event) {
	//So, here's your basic state template
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//This code will run once when the state is brand new.
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//This code will be executed during the step event.
		}break;
	
		//DRAW---------------------------------------
		case TRUESTATE_DRAW:
		{
			//And this code will be exeucted during the draw event
		}break;
	
		//FINAL---------------------------------------
		case TRUESTATE_FINAL:
		{
			//This code will run once right before switching to a new state.
		}break;
	}
}

function state_ai_slime_hurt(_event) {
	//So, here's your basic state template
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//This code will run once when the state is brand new.
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//This code will be executed during the step event.
		}break;
	
		//DRAW---------------------------------------
		case TRUESTATE_DRAW:
		{
			//And this code will be exeucted during the draw event
		}break;
	
		//FINAL---------------------------------------
		case TRUESTATE_FINAL:
		{
			//This code will run once right before switching to a new state.
		}break;
	}
}
