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
			show_debug_message("Running game setup script");
			//If we are loading a save, set seed and create entities from save file
			
			//Set the game seed to whatever is in the game struct
			random_set_seed(global.game.seed);
			
			//Create list of entities
			entityList = array_create(0);
						
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
			
			//Create the turn order controller
			instance_create_layer(x, y, "la_controllers", co_turnOrder);
			
			//Create the overlay of tiles
			instance_create_layer(x, y, "la_controllers", co_tileOverlay);
	
	

			
			//Create the shooter controller
			//Arrows have been disabled, don't really fit theme
			//instance_create_layer(x, y, "la_controllers", co_shooter);
			
			//Create the inital ai turn order.
			co_gameManager.refreshRoomValues();
			co_turnOrder.createAiTurnOrder();
			co_saveLoad.loadGameSave = false; //We are done loading the game, if we were loading in the first place.  Set to false.
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
			co_gameManager.runRoomConditions();
			ob_player.turnActive = true;
			ob_player.endTurn = false;
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//Watch for player to complete turn
			if(!instance_exists(ob_player)) {
				//ob_player does not exist.  Go to inactive state as we are reloading.
				truestate_switch(STATES.INACTIVE);
			} else{
				if(ob_player.endTurn == true) truestate_switch(STATES.AI_ACTIVE);	
			}
			//if(ob_player.endTurn == true) truestate_switch(STATES.GAME_SETUP);

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
			if(instance_exists(ob_player)) {
				//Only run if ob_player exists
				if(ob_player.movingRooms == true) {
					//Player is in new room, deactivate old room
					//co_gameManager.deactivateRoom(to_room_x(ob_player.lastRoomGridX), to_room_y(ob_player.lastRoomGridY));
					ob_player.movingRooms = false;	
					co_gameManager.refreshRoomValues(); //Refresh after player has moved
					co_turnOrder.createAiTurnOrder();
					truestate_switch(STATES.PLAYER_ACTIVE);
				}
				else {
					truestate_switch(STATES.AI_ACTIVE);	
				}
				co_grid.refreshRangeGrids();
			}
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




