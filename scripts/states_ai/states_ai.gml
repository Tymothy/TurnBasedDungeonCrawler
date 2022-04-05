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
			attackValid = false;
			directAttack = false;
			property.chosenAttack = noone;
			
			//Run checks
			if(property.attacks.direct == true) {
				directAttack = check_direct_attack(to_grid(property.targetObject.x), to_grid(property.targetObject.y));
				if(directAttack != false){
					property.chosenAttack = ATTACK.DIRECT;	
				}
			}	
			//Determine if attack is possible
			//switch(property.chosenAttack) {
			//	case ATTACK.DIRECT:
			//		//Attacker must start near target, then attack directly
					
					
			//		var _distX = to_grid(abs(property.targetObject.x - self.x));
			//		var _distY = to_grid(abs(property.targetObject.y - self.y));
			//		//Determine if target is within reach
			//		if(_distX <= property.meleeAttackRange && _distY <= property.meleeAttackRange) {
			//			//Target able to be attacked
			//			attackValid = true;
			//		}
			//		else {
			//			attackValid = false;
			//		}
					
					
			//	break;
			
			//}
			
			//if(property.chosenAttack == noone) truestate_switch(STATES.MOVE);
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//This code will be executed during the step event.
			switch(property.chosenAttack) {
				case noone:
					//No attack is valid, go to move state
					truestate_switch(STATES.MOVE);
					break;
				
				
				case ATTACK.DIRECT:
						//Run the direct attack
						property.targetObject.takeDamage(property.meleeAttackPower);
						show_debug_message("TODO: ADD ANIMATION HERE");
					break;
				
				
				
			}
			
			//This should run only after animation is completed (once animation is put in
			property.chosenAttack = noone;
			
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
					targArr = move_direct(self.property.collisionGrid, property.targetObject.x, property.targetObject.y);	
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
