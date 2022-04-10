//Scripts for the door state
function state_door_locked(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//This code will run once when the state is brand new.
			truestate_clear_history();
			if(!DOOR_UNLOCK) lockDoor(); //Only allow locked doors with DOOR_UNLOCK
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			if(co_gameManager.hostilesInRoom == false) {
				truestate_switch(STATES.OPEN);	
			}
			


		}break;
	
		//DRAW---------------------------------------
		case TRUESTATE_DRAW:
		{

		}break;
	
		//FINAL---------------------------------------
		case TRUESTATE_FINAL:
		{

		}break;
	}
}

function state_door_open(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//Open the doors
			openDoor();
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{ 
			if(co_gameManager.hostilesInRoom == true && ob_player.truestate_current_state == STATES.IDLE) {
				truestate_switch(STATES.LOCKED);	
			}

		}break;
	
		//DRAW---------------------------------------
		case TRUESTATE_DRAW:
		{

		}break;
	
		//FINAL---------------------------------------
		case TRUESTATE_FINAL:
		{

		}break;
	}
}
