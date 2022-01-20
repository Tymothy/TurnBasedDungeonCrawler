function state_ai_wait(_event) {
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
function state_ai_attack(_event) {
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

function state_ai_move(_event) {
	//So, here's your basic state template
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			aiPath = path_add();			
			mp_clear_entity(); //Clears self from entity grid
			
			targX = -1;
			targY = -1;
			twerpTimer = 0;
			entity = noone;
			
			calcPath();
			// if(mp_grid_get_cell(co_grid.mpGrid_entity, gridTargX, gridTargY) == -1) {
			
			if(entity != false) {	
				//Target cell is occupied, unable to move there.
				//Since we cannot move to target cell, try to reroute to find a valid path
				
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
					//Path not found, set targets to current position to exit infinite loop
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
			draw_path(aiPath, x, y, false);
		}break;
	
		//FINAL---------------------------------------
		case TRUESTATE_FINAL:
		{
			mp_add_entity();  //Adds self to entity grid
			path_delete(aiPath);
		}break;
	}
}

function state_ai_hurt(_event) {
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
