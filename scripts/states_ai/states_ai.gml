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
			targArr = move_direct(self.attributes.collisionGrid, attributes.targetObject.x, attributes.targetObject.y);

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
