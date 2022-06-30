//Scripts for the player state
function state_player_wait(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			//This code will run once when the state is brand new.
			//truestate_clear_history();
			targetObject = noone;
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//Wait for co_gameManger to make player active
			if(turnActive == true) {
				truestate_switch(STATES.IDLE);
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
			startGridX = to_grid(x);
			startGridY = to_grid(y);
			
			//Reset attack variables
			meleeDirect = false;
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//If a tile is touched, act on touch if possible
			//Player waits for a touch
			var _qt = false //quick testing below.  Should be false to disable messages
			var _ts = get_touch_state_on_change();

				gridX = get_gridX();
				gridY = get_gridY();
				
				targX = from_grid(gridX);
				targY = from_grid(gridY);
				switch(_ts) {
					case -1:
						//No state change, don't do anything
					break;
					//TODO: Handle hold touch
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
						if(get_drag() == false) {
							//If dragging, we don't want to move
							var _move = true;
						
							//Check entity clicked on
							var _entity = check_entity(gridX, gridY);
							if(_entity != false) {
								//entity is in grid square.  Can we move onto it?
								
								//Check first to see if we want to attack entity
								if(property.attacks.meleeDirect == true){
									meleeDirect = check_direct_attack(gridX, gridY);
									//If we are attacking, don't move.									
									if(meleeDirect != false) _move = false;
								}

								var _parOb = object_get_parent(_entity.object_index);
							
								switch(_parOb) {
									case ob_par_hostile: 
										_move = false;
										break;
									
									case ob_par_environment:
										break;
								
								}
							
							}							
							//Check if click is on self
							if(gridX == to_grid(x) && gridY == to_grid(y)) {
								//Touch was released on player
								//Do not move tiles
								_move = false;
							}


							//Check if tile has collision restricting movement
							var _collide = co_grid.tileGrid[# gridX, gridY][$ "_collidePlayer"];
							if(_collide == true) {
								//Tile has collision and player cannot move to it
								_move = false;
										
							}
						
							//Check if touch is inside of movement area
							if(abs(to_grid(x) - gridX) <= property.moveSpeed && abs(to_grid(y) - gridY) <= property.moveSpeed)
							{
								//Touch is inside of movement area, do not disallow movement
							}
							else {
								_move = false;
								
								//Touch is outside movement area, we can queue moves to get there
								if(_collide == false) {
									//tile touched is a valid tile to get to
									
									//Check for an empty room
									if(co_gameManager.hostileCount == 0) {
										_move = true;	
									}
									
								}
							}
							
							
							//If direct attack is being used, go directly to attack
							if(meleeDirect != false) {
								truestate_switch(STATES.ATTACK);	
							}


							if(_move == true) {
								//If tile is not restricted, allow move.
								truestate_switch(STATES.MOVE);
							}
						}
									
							
					break;
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
			//Remove current position from entity grid			
			targArr = move_direct(self.property.collisionGrid, targX, targY);
			doorFlag = false; //Used to ensure once a door is used, player will go to next room
			currentRoomX = to_room_x(to_grid(x));
			currentRoomY = to_room_y(to_grid(y));
			
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//targX/targY
			var _repeatMove = false;
			//targArr holds the pathed variables
			if(move_entity(targArr[0], targArr[1])){
				
				//When entity is done moving, check if they are on a tile to do something with, like a door
								
				if(place_meeting(x,y, ob_door) && doorFlag == false) {
					doorFlag = true;
					if(LOGGING) show_debug_message("Target square contains a door");
					
					
					//Find the room the player is in
					var _tempX = to_grid(x);
					var _tempY = to_grid(y);
					
					var _tempX = to_room_x(_tempX);
					var _tempY = to_room_y(_tempY);
					
					var _centerX = from_room_x(_tempX);
					var _centerY = from_room_y(_tempY);
					
					var _dir = point_direction(_centerX, _centerY, to_grid(targX), to_grid(targY));
					
					_dir = round(_dir / 90);
					
					//Set targ coord to the next room, then repeat move state to move
					switch(_dir) {


						case 1: //NORTH
							if(LOGGING) show_debug_message("Move player north");
							do {
								targY -= TILE_SIZE;	
								var _result = co_grid.tileGrid[# to_grid(targX), to_grid(targY)][$ "_collidePlayer"];//Find if the player can collide with current tile
							}
							until (_result == 0);
							targY -= TILE_SIZE;	//Move one past door
							
							break;
							
						case 2: //WEST
							if(LOGGING) show_debug_message("Move player west");
							//targX -= TILE_SIZE * 2;
							//Find next available tile
							do {
								targX -= TILE_SIZE;	
								var _result = co_grid.tileGrid[# to_grid(targX), to_grid(targY)][$ "_collidePlayer"];//Find if the player can collide with current tile
							}
							until (_result == 0);
							targX -= TILE_SIZE;	//Move one past door
							break;		
							
						case 3: //SOUTH
							if(LOGGING) show_debug_message("Move player south");
							do {
								targY += TILE_SIZE;	
								var _result = co_grid.tileGrid[# to_grid(targX), to_grid(targY)][$ "_collidePlayer"];//Find if the player can collide with current tile
							}
							until (_result == true);
							targY += TILE_SIZE * 3;	//Move one past door
							
							break;	
							
						case 4: //EAST
							if(LOGGING) show_debug_message("Move player east");
							//targX += TILE_SIZE * 2;
							//Find next available tile
							do {
								targX += TILE_SIZE;	
								var _result = co_grid.tileGrid[# to_grid(targX), to_grid(targY)][$ "_collidePlayer"];//Find if the player can collide with current tile
							}
							until (_result == 0);
							targX += TILE_SIZE; //Move one past door

							break;
						
					}
					
					movingRoomsFunc();
					_repeatMove = true;
		
				}
		
				//Check to see if we are moving farther
				if(targArr[0] != targX || targArr[1] != targY) {
					//If we are moving, we do not want to be stopped by collision
					if(movingRooms == true){
						var _cg = co_grid.mpGrid_noCollision;
					} else {
						var _cg = self.property.collisionGrid;
					}
					
					targArr = move_direct(_cg, targX, targY);
					_repeatMove = true;	
				}
				if(_repeatMove == true) {
					//Need to move player again, repeat move
					truestate_switch(STATES.MOVE);
				}
				else {
				//No further movement done, move to attack state						
					truestate_switch(STATES.ATTACK);			
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
			//Add current position back to entity grid
			xGridCoord = to_grid(x);
			yGridCoord = to_grid(y);
			mp_add_entity();
		}break;
	}
}

function state_player_attack(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			attackArrayCounter = 0;
			attacking = false;
			attackValid = false;			
			attackFlag = false; //Used to track if an attack has been selected and prevents multiple attacks
			originX = x;
			originY = y;
			targX = x;
			targY = y;
			target = noone; //Target of attack used in step
			//validAttacks = check_valid_attacks();
			//if(validattacks.meleeDirect = true) {
			//	if(LOGGING) show_debug_message("Direct attack valid");	
			//}
			

			////Determine if attack is possible
			
			//Direct Attack
			if(attackFlag == false && property.attacks.meleeDirect == true) {
				//Object is able to attack
				
				//Check if direct attack is being used
				if(meleeDirect != false) {
					//We do want to direct attack
					attackArray[attackArrayCounter] = meleeDirect;
					attackArrayCounter++;
					
					attackFlag = true;
				}
				
			} //End Direct Attack
			
			if(attackFlag == false && property.attacks.meleeSlide == true) {
					//What makes a target eligible?  Being part of the hostile parent
					for(var i =  xGridCoord - 1; i <= xGridCoord + 1; i++) {
						for(var j = yGridCoord - 1; j <= yGridCoord + 1; j++) {
							var _tempEnt = check_entity(i, j);
							if(_tempEnt != false){
								//Space is not blank, find out if object is a valid target
								if(object_is_ancestor(_tempEnt.object_index, ob_par_hostile)){
									//Object is an attackble hostile, see if it was close at start of turn
									if(abs(to_grid(_tempEnt.x) - startGridX) <= 1 && abs(to_grid(_tempEnt.y) - startGridY <= 1)) {
										//Object started turn near player.  Mark for attack
										attackArray[attackArrayCounter] = _tempEnt;
										attackArrayCounter++;
										attackFlag = true;
										
									}
										
								}
									
							}
								
						}
					}
			}//End Slide attack

			if(attackArrayCounter > 0){
				attackValid = true;
			}
			if(attackValid == false) truestate_switch(STATES.END);
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//This code will be executed during the step event.
			var _animationSpeed = 5;
			if(attackValid == true) {
				//Start attacking enemies
				//While attacking is true, the animation is playing on an enemy.  Wait for 1 enemy to be
				//finished being attacked before moving to next one
				
				//Get Target
				if(attackArrayCounter >= 0 && attacking == false) {
					//runs once per enemy
					attacking = true;
					attackArrayCounter--;//Remove first to account for the off by one setting
					target = attackArray[attackArrayCounter];
					var _dir = point_direction(originX, originY, target.x, target.y);
					targX = lengthdir_x(TILE_SIZE / 2, _dir);
					targY = lengthdir_y(TILE_SIZE / 2, _dir);
				}
				
				if(target != noone) {
					//Animate towards target
					if(move_entity(originX + targX, originY + targY, _animationSpeed)) {
						//Move towards enemy as part of attack
						//This runs when done with movement
						array_delete(attackArray, attackArrayCounter, 1);		
						target.takeDamage(property.meleeAttackPower);
						target = noone; //Reset target to start moving back
					}
				}
				
				if(target == noone && attacking == true) {
					if(move_entity(originX, originY, _animationSpeed)) {
						//Runs after attack is done and object is back at the original state.
						attacking = false;
					}					
					
				}
				
				if(attackArrayCounter <= 0 && attacking == false) {
					attackValid = false;					
				}
			}
	
			if(attackValid == false) {
				//After finished attacking, end the state.
				truestate_switch(STATES.END);	
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

function state_player_end(_event){
	switch(_event)
	{
		//NEW---------------------------------------
		case TRUESTATE_NEW:
		{
			endTurn = true;					
			turnActive = false;
			
			//Check if we ended turn on anything important
			//if(place_meeting(x, y, ob_ladderDown)) {
			//	co_gameManager.moveDownLevel();
				
			//}
			
		}break;
	
		//STEP---------------------------------------
		case TRUESTATE_STEP:
		{
			//This code will be run during step event
			
			
			//Handled all end turn items, go back to waiting for next turn
			truestate_switch(STATES.WAIT);

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