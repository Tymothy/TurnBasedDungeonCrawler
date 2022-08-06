function state_ai_wait(_event) {
	//So, here's your basic state template
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			if(moveCounter != 0 && moveCounter < property.moveSpeed) {
				show_debug_message("Move counter: " + string(moveCounter));
				truestate_switch(STATES.MOVE);	
			} else {
				aiActive = false;
				moveCounter = 0;				
			}
			//This code will run once when the state is brand new.
				
			truestate_clear_history();
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//Enemy waits it's turn before being allowed to go
			
			//When AI turn starts, determine movement
			if(aiActive == true && moveCounter == 0) {
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
			meleeDirect = false;
			rangeLine = false;
			//meleeSlide
			chosenAttack = noone;
			
			//Run checks, from least desirable attack to most desirable
			if(property.attacks.meleeDirect == true) {
				meleeDirect = check_direct_attack(to_grid(targetObject.x), to_grid(targetObject.y));
				if(meleeDirect != false){
					chosenAttack = ATTACK.DIRECT;	
				}
			}	
			
			if(property.attacks.meleeSlide == true) {
			//Nothing here, need for player scripts though	
			}
			
			if(property.attacks.rangeLine == true) {
				rangeLine = check_range_line_attack(to_grid(targetObject.x), to_grid(targetObject.y));
				if(rangeLine != false){
					chosenAttack = ATTACK.RANGED_PROJECTILE;	
				}				
				
			}
			
			if(property.attacks.rangeDiag == true) {
				rangeDiag = check_range_diag_attack(to_grid(targetObject.x), to_grid(targetObject.y));
				if(rangeDiag != false){
					chosenAttack = ATTACK.RANGED_PROJECTILE;	
				}		
				
				
			}
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//This code will be executed during the step event.
			switch(chosenAttack) {
				case noone:
					//No attack is valid, go to move state
					truestate_switch(STATES.MOVE);
					break;
				
				
				case ATTACK.DIRECT:
						//Run the direct attack
						targetObject.takeDamage(property.meleeAttackPower);
						show_debug_message("TODO: ADD ANIMATION HERE");
						if(LOGGING) show_debug_message(string(property.name)+ " " + string(id) +" direct attacked " + string(targetObject.property.name) + " " + string(targetObject.id));
					break;
				
				case ATTACK.RANGED_PROJECTILE:
						targetObject.takeDamage(property.rangeAttackPower);
						show_debug_message("TODO: ADD ANIMATION HERE");
						if(LOGGING) show_debug_message(string(property.name)+ " " + string(id) +" range projectiled attacked " + string(targetObject.property.name) + " " + string(targetObject.id));
						
						with(instance_create_layer(x, y, "la_projectiles", ob_projectile)){
							vel = 5;
							targetObject = other.targetObject;
							dir = point_direction(x, y, targetObject.x, targetObject.y);
							
						}
						 
					break;
				
				
			}
			
			//This should run only after animation is completed (once animation is put in)
			chosenAttack = noone;
			
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
			moveCounter++;
			
			switch(property.movePattern) {
				case MOVE.NONE:
					targArr = move_direct(self.property.collisionGrid, self.x, self.y);	
					break;
					
				case MOVE.SEEK_DIRECT:
					targArr = move_direct(self.property.collisionGrid, targetObject.x, targetObject.y);	
					break;
					
				case MOVE.SEEK_RANGE:
					//Apply a score to all tiles in room based on distance player has to walk
					//The higher the weight, the more valuable the square is
					
					//Search for highest weight that is within 2 tiles and that is still within attack range
					var _goal = false;
					var _line = 0;
					var _diag = 0;
					var _tempScore = 0;
					var _topScore = 0;
					var _targX = 0;
					var _targY = 0;

					var _xOff = co_gameManager.leftGridX;
					var _yOff = co_gameManager.topGridY;
					
					for(var i = 0; i < ROOM_SIZE_WIDTH; i++) {
						for(var j = 0; j < ROOM_SIZE_HEIGHT; j++) {
							if(property.attacks.rangeDiag == true) {
								_diag = ds_grid_get(co_grid.rangeDiagGrid, i, j);
								if(_diag > 0 && _diag < property.rangeAttackRange){
										_goal = true;
									
								}
								_tempScore = _diag;
							}
					
							if(property.attacks.rangeLine == true) {
								_line = ds_grid_get(co_grid.rangeLineGrid, i, j);
								if(_line > 0 && _line < property.rangeAttackRange) {									
										_goal = true;
									}
								if(_line > _tempScore) _tempScore = _line;
							}	
							
							//Possible Bug, all range enemies will target the same tile
							_tempScore = max(.5, _tempScore - point_distance(i + _xOff, j + _yOff, _targX, _targY) * .25);
							
							if(_goal = true) {
								//Check if tile is even a possible pathable tile
								var _path = mp_grid_get_cell(self.property.collisionGrid, i + _xOff, j + _yOff);
								var _ent = co_grid.tileGrid[# i + _xOff, j + _yOff][$ "_entityInTile"];
								if(_tempScore > _topScore && _path == 0 && _ent == false) {
									//Spot is more desirable, target it
									_topScore = _tempScore;
									_targX = i + _xOff;
									_targY = j + _yOff;
								}
								
							}
							
							_goal = false;
							_tempScore = 0;
							_line = 0;
							_diag = 0;
						}
						
					}
					
					//Possible bug, could target unreachable tiles
					if(LOGGING) show_debug_message(string(property.name)+ " " + string(id) +" target square " + coords_string(_targX, _targY));
					targArr = move_direct(self.property.collisionGrid, from_grid(_targX), from_grid(_targY));
					
					
					//Use check line attacks to see if object can be attacked
					
					//For loop that loops through the entire room for the target object.
					//Run check_attack for each square
					
					break;
				
			}
			

			//targArr = calc_path(); //get the X and Y coords to move to (room coords)
			
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			if(move_entity(targArr[0], targArr[1])){
				//When entity is done moving, end entities turn
					truestate_switch(STATES.WAIT);			

			}
		}break;
	
		//DRAW---------------------------------------
		case TRUESTATE_DRAW:
		{
			//draw_path(entityPath, x, y, false);
		}break;
	
		//FINAL---------------------------------------
		case TRUESTATE_FINAL:
		{
			mp_add_entity();  //Adds self to entity grid
			
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
			if(property.hp <= 0) {
				entityDead();
			}
			
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
