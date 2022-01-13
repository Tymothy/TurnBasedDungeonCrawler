//Scripts for the player state
function state_player_wait(_event){
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
			//Wait for co_gameManger to make player active
			if(turnActive == true) truestate_switch(STATES.IDLE);

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

function state_player_idle(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			
			//This code will run once when the state is brand new.
			gridX = -1;
			gridY = -1;
			endTurn = false;
			
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//If a tile is touched, act on touch if possible
			//Player waits for a touch
			var _qt = false //quick testing below.  Should be false to disable messages
			var _ts = get_touch_state_on_change();

				var gridX = get_gridX();
				var gridY = get_gridY();
				switch(_ts) {
					case -1:
						//No state change, don't do anything
					break;
					
					case STATES.IDLE:
						if(_qt) show_debug_message("TOUCH_STATE Change: Idle");	
					break;
					
					case STATES.NEW_TOUCH:
						if(_qt) show_debug_message("TOUCH_STATE Change: New touch");	
					break;
				
					case STATES.SAME_TOUCH:
						if(_qt) show_debug_message("TOUCH_STATE Change: Same touch");	
					break;
					
					case STATES.DIFFERENT_TOUCH:
						if(_qt) show_debug_message("TOUCH_STATE Change: Diff touch");	
					break;
					
					case STATES.DRAGGING:
						if(_qt) show_debug_message("TOUCH_STATE Change: Dragging");	
					break;
					
					case STATES.RELEASE:
						if(_qt) show_debug_message("TOUCH_STATE Change: Release");	
							if(abs(to_grid(x) - gridX) <= attributes.moveSpeed && abs(to_grid(y) - gridY) <= attributes.moveSpeed)
							{
								//Touch has occurred within players move space, attempt to move there/interact with tile
								if(gridX == to_grid(x) && gridY == to_grid(y)) {
									//Touch was released on player
									//Do not move tiles
								}
								else {
									//Check if tile is available to move to
									//if(mp_grid_get_cell(co_grid.mpGrid_entity, gridTargX, gridTargY) == -1) {
										//entity is in grid square	
									
									//}
								ob_player.x = from_grid(gridX);
								ob_player.y = from_grid(gridY);					
								//Check if tile is attackable, if so attack
								endTurn = true;									
								}
								

					
							}						
					break;
				}
					
				//Check if player took an turn ending action
				if(endTurn == true) {
						truestate_switch(STATES.WAIT);	
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

function state_player_move(_event){
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
			//This code will be run during step event

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

function state_player_attack(_event){
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
			//This code will be run during step event

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

function state_player_hurt(_event){
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
			//This code will be run during step event

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
	
function state_player_item_get(_event){
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
			//This code will be run during step event

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