//Scripts for the player state
function state_door_idle(_event){
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
