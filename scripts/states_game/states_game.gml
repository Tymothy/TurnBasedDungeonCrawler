//Scripts for the game state
function state_game_inactive(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//This code will run once when the state is brand new.
			//truestate_switch(STATES.GAME_SETUP);	
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//If in the game room, start setting up the game room
			
			if(room == rm_game) {
				truestate_switch(STATES.GAME_SETUP);
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
function state_game_setup(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//Run the packed room generation to generate the game room
			instance_create_layer(x, y, "la_controllers",co_roomGen);

			//All rooms are created, create the collision grid
			instance_create_layer(x,y, "la_controllers", co_grid);

			//Fill the rooms with content
			instance_create_layer(x, y, "la_controllers", co_createDoors);
			
			//Restrict spawns
			restrict_spawns_near_doors();
			
			//Spawn entities in game room, including player
			instance_create_layer(x,y, "la_controllers", co_spawnManager);
			
			//Get list of entities
			createListOfEntities();
			
			//Create the turn order controller
			instance_create_layer(x, y, "la_controllers", co_turnOrder);
			
			//Create the overlay of tiles
			instance_create_layer(x, y, "la_controllers", co_tileOverlay);
	
	
			instance_create_layer(x, y, "la_controllers", co_saveLoad);
			
			//Create the shooter controller
			//Arrows have been disabled, don't really fit theme
			//instance_create_layer(x, y, "la_controllers", co_shooter);
			
			//Create the inital ai turn order.
			co_gameManager.refreshRoomValues();
			co_turnOrder.createAiTurnOrder();
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//Waits for the game to be setup before switching to the player's turn
			if(instance_exists(co_spawnManager)) {
				if(co_spawnManager.done == true) {
					truestate_switch(STATES.PLAYER_ACTIVE);	
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

function state_game_player_active(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			co_gameManager.refreshRoomValues(); //Refresh room values at the beginning of the turn to check conditions
			co_gameManager.checkConditions();
			ob_player.turnActive = true;
			ob_player.endTurn = false;
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//Watch for player to complete turn
			if(ob_player.endTurn == true) truestate_switch(STATES.AI_ACTIVE);	

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
			if(ob_player.movingRooms == true) {
				//Player is in new room, deactivate old room
				co_gameManager.deactivateRoom(to_room_x(ob_player.lastRoomGridX), to_room_y(ob_player.lastRoomGridY));
				ob_player.movingRooms = false;		
				co_turnOrder.createAiTurnOrder();

				

				truestate_switch(STATES.PLAYER_ACTIVE);
			}
			else {
				truestate_switch(STATES.AI_ACTIVE);	
			}
			co_grid.refreshRangeGrids();
		}break;
	}

}

function state_game_ai_active(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			co_turnOrder.startAiTurn();
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
					truestate_switch(STATES.PLAYER_ACTIVE);
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




