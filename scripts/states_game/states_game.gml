//Scripts for the game state
function state_game_setup(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//Run the packed room generation to generate the game room
			instance_create_layer(x, y, "la_controllers",co_packedRoomManager);

			//All rooms are created, create the collision grid
			instance_create_layer(x,y, "la_controllers", co_grid);

			//Spawn entities in game room, including player
			instance_create_layer(x,y, "la_controllers", co_spawnManager);
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//Waits for the game to be setup before switching to the player's turn
			if(instance_exists(ob_player)) {
				truestate_switch(STATES.PLAYER_STARTING);	
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

function state_game_player_starting(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//Calculate if player is alive
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			truestate_switch(STATES.PLAYER_ACTIVE);	
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

function state_game_player_active(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			TOUCH_STATE = STATES.IDLE;
			touchChange = false;
			oldTouchState = STATES.IDLE;
			
			currentTouch = -1; //used to track the current touch to work with later on
			gridX = -1;
			gridY = -1;
			
			oldTouch = currentTouch;
			oldGridX = gridX;
			oldGridY = gridY;
			
			hasTouch = false; //True when we are tracking a touch
			dragging = false;
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//Watch for player input
		#region Determine touch state			
			currentTouch = get_current_touch();
			
			if(currentTouch != -1) {
				hasTouch = true;	
				gridX = get_touch_gridX(currentTouch);
				gridY = get_touch_gridY(currentTouch);
			}
			else {
				hasTouch = false;	
			}
			
			switch(hasTouch) {
				case true:
				//Screen is being touched
					switch(oldTouch) {
						case -1: 
							//Touch is new from idle.  We will want to do something
							TOUCH_STATE = STATES.NEW_TOUCH;
						break;
						
						default:
							if(oldTouch == currentTouch) {
								//This is the same touch, nothing new
								TOUCH_STATE = STATES.SAME_TOUCH;
							}
							else {
								//Screen was being touched before, and it still is, but with different finger.	
								TOUCH_STATE = STATES.DIFFERENT_TOUCH;
							}
						break;
					}
				
				break;
				
				
				case false:
				//Screen is not being touched
					switch(oldTouch) {
						case -1:
							//No change, stay idle.
							TOUCH_STATE = STATES.IDLE;
						break;
						
						default:
							//There was a release, see if we want to execute
							switch(dragging) {
								case false:
									//We were not dragging, we want to perform action/movement
									TOUCH_STATE = STATES.RELEASE;
								break;
								
								case true:
									//We were dragging, we don't want to perform actions/movments
									TOUCH_STATE = STATES.DRAGGING;
								break;	
							}

						break;
						
					}
				break;
				
			}
			
			if(oldTouchState != TOUCH_STATE) touchChange = true;
			if(currentTouch != -1)	dragging = get_touch_drag(currentTouch);
			
	#endregion			
			//show_debug_message("Touch State Changed: " + string(TOUCH_STATE));
			if(touchChange == true)
			{
				show_debug_message("Touch State Changed: " + string(TOUCH_STATE));
				switch(TOUCH_STATE) {
					case STATES.IDLE:
						
					break;
					
					case STATES.NEW_TOUCH:
					
					break;
				
					case STATES.SAME_TOUCH:
					
					break;
					
					case STATES.DIFFERENT_TOUCH:
					
					break;
					
					case STATES.DRAGGING:
					
					break;
					
					case STATES.RELEASE:
					
					break;
				}
				
			}
				
			//	if(LOGGING) show_debug_message("Execute touch code");

			//	//If touch is square player is on, show available spaces	
			//	if(to_grid(ob_player.x) == gridX && to_grid(ob_player.y) == gridY) {
			//		//Player has been touched
			//		if(LOGGING) show_debug_message("Player has been touched");
			//		//TODO: Show all available move tiles
			//	}
				
			//	if(co_grid.tileGrid[# gridX, gridY][$ "_collidePlayer"] == false)
			//	{
			//		//Touch has occured on a tile the player could theoretically move to.	
			//		if(LOGGING) show_debug_message("Tile touched player could theoretically move to: " + coords_string(gridX, gridY));
			//		//Determine a path from

			//	}
				
			//	if(abs(to_grid(ob_player.x) - gridX) <= ob_player.moveSpeed && abs(to_grid(ob_player.y) - gridY) <= ob_player.moveSpeed)
			//	{
			//		//Touch has occurred within players move space, attempt to move there/interact with tile
			//		ob_player.x = from_grid(gridX);
			//		ob_player.y = from_grid(gridY);					
			//		//Check if tile is attackable, if so attack
					
			//	}
				
				
			//}
			//if(_executeRelease == true)
			//{
			//	if(LOGGING) show_debug_message("Execute release code");	
			//}
			
			oldTouch = currentTouch;
			oldGridX = gridX;
			oldGridY = gridY;
			oldTouchState = TOUCH_STATE; //Used so we can track if state changes on next step
			touchChange = false; //Reset change back to false as we are done handling it
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

function state_game_player_ending(_event){
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

function state_game_ai_starting(_event){
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

function state_game_ai_active(_event){
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

function state_game_ai_ending(_event){
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

function state_game_turn_end(_event){
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

function state_game_paused(_event){
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

function state_game_inactive(_event){
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
			//If in the game room, start setting up the game room
			if(room == rm_game) truestate_switch(STATES.SETUP);	
			
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


