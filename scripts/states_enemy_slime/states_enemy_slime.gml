function state_ai_slime_wait(_event) {
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
				//Start attack phase
				truestate_switch(STATES.ATTACK);
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
function state_ai_slime_attack(_event) {
	//So, here's your basic state template
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//This code will run once when the state is brand new.
			attackValid = false;
			//Determine if attack is possible
			switch(attributes.attackStyle) {
				case ATTACK.DIRECT:
					//Attacker must start near target, then attack directly
					var _distX = to_grid(abs(attributes.targetObject.x - self.x));
					var _distY = to_grid(abs(attributes.targetObject.y - self.y));
					//Determine if target is within reach
					if(_distX <= attributes.attackRange && _distY <= attributes.attackRange) {
						//Target able to be attacked
						attackValid = true;
					}
					else {
						attackValid = false;
					}
				break;
			
			}
			
			if(attackValid == false) truestate_switch(STATES.MOVE);
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//This code will be executed during the step event.
			if(attackValid == true) {
				attributes.targetObject.takeDamage(attributes.attackPower);
				show_debug_message("ATTACKED");
				attackValid = false;
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
				}
				until (entity == false || i == 4);
				
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
				truestate_switch(STATES.WAIT);
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



function state_ai_slime_hurt(_event) {
	//So, here's your basic state template
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//Calculate if AI is dead
			var _removeEntity = false;
			if(attributes.hp <= 0) _removeEntity = true;
			
			//Remove entity
			if (_removeEntity == true) remove_entity(id);
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//This code will be executed during the step event.
			
			truestate_switch(truestate_previous_state);
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
