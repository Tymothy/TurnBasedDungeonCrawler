function state_ai_wait(_event) {
	//So, here's your basic state template
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//This code will run once when the state is brand new.
			aiActive = false;
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
			switch(property.movePattern) {
				case MOVE.SEEK_DIRECT:
					targArr = move_direct(self.property.collisionGrid, targetObject.x, targetObject.y);	
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
			var _removeEntity = false;
			if(property.hp <= 0) _removeEntity = true;
			
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
