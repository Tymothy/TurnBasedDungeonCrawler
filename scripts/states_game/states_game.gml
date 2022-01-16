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
			
			//Create the turn order controller
			instance_create_layer(x, y, "la_controllers", co_turnOrder)
			
			//Create the inital ai turn order.
			//TODO: Will need to account for multiple rooms in future
			co_turnOrder.createAiTurnOrder();
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//Waits for the game to be setup before switching to the player's turn
			if(instance_exists(co_spawnManager)) {
				if(co_spawnManager.done == true) {
				truestate_switch(STATES.PLAYER_STARTING);	
				}
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
			ob_player.turnActive = true;
			ob_player.endTurn = false;
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//Watch for player to complete turn
			if(ob_player.endTurn == true) truestate_switch(STATES.PLAYER_ENDING);	
			
			
			
			//TODO: Move this into the co_touchMaster object

			//show_debug_message("Touch State Changed: " + string(TOUCH_STATE));
			
				
				

				
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
			truestate_switch(STATES.AI_STARTING);	
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
			co_turnOrder.startAiTurn();
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			truestate_switch(STATES.AI_ACTIVE);	
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
			aiActive = false; //This is used to track if an ai is active
			aiGoing = noone; //Holds the instance id of the ai actively going
			stateEnding = false;
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//Possible bug, if AI is destoryed during their own turn, not sure
			//If this would break this state machine
			
			//Execute AI turns one by one.
			if(aiActive = false)  {
				aiGoing = co_turnOrder.getNextAiTurn();
				
				//Check if any are left to go
				if(aiGoing == false) {
					truestate_switch(STATES.AI_ENDING);
					stateEnding = true;
				}
				else {
					aiGoing.aiActive = true;
					aiActive = true;
				}
			}
			
			//Track if AI has finished turn
			if(stateEnding == false)
			{
				if(aiGoing.aiActive == false) aiActive = false; //If this is ran while state is trying to end, game crashes for some reason
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
			truestate_switch(STATES.TURN_END);
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
			//Check for win/loss conditions
			truestate_switch(STATES.PLAYER_STARTING);
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


