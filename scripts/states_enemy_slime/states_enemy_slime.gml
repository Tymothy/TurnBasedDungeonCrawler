function state_ai_slime_idle(_event) {
	//So, here's your basic state template
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
			//Enemy waits it's turn before being allowed to go
			
			//When AI turn starts, determine movement
			if(aiActive == true) {
				//Determine what state to take
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
	
function state_ai_slime_move(_event) {
	//So, here's your basic state template
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			targX = -1;
			targY = -1;
			twerpTimer = 0;
			length = MOVE_LENGTH;
			
			pathToPlayer = path_add();
			mp_grid_path(co_grid.mpGrid_collideOther, pathToPlayer, x, y, ob_player.x, ob_player.y, true);
			//TODO: Track collision with other enemies to prevent them from overlapping
			
			//Enemies can only move one tile at a time, per turn
			var _xx = path_get_point_x(pathToPlayer, 1);
			var _yy = path_get_point_y(pathToPlayer, 1);
			var dir = point_direction(x, y, _xx, _yy);
						
			//Calc grid point to move to
			targX = to_grid(_xx);
			targY = to_grid(_yy);
			gridTargX = targX;
			gridTargY = targY;
			//Get the room coords back.  This is need to ensure x and y are
			//On the actual grid coords, and not slightly off
			targX = from_grid(targX);
			targY = from_grid(targY);
			
			

		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			
			x = twerp(TwerpType.inout_cubic, x, targX, twerpTimer / length);
			y = twerp(TwerpType.inout_cubic, y, targY, twerpTimer / length);
			twerpTimer += d(1);
			
			if(x = targX && y = targY) {
				//Movement complete
				aiActive = false;
				truestate_switch(STATES.IDLE);
			}
		}break;
	
		//DRAW---------------------------------------
		case TRUESTATE_DRAW:
		{
			draw_path(pathToPlayer, x, y, false);
		}break;
	
		//FINAL---------------------------------------
		case TRUESTATE_FINAL:
		{
			path_delete(pathToPlayer);
		}break;
	}
}

function state_ai_slime_flee(_event) {
	//So, here's your basic state template
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

function state_ai_slime_attack(_event) {
	//So, here's your basic state template
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

function state_ai_slime_hurt(_event) {
	//So, here's your basic state template
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
