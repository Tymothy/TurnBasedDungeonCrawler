/// @desc Initialize State Machine and properties
event_inherited();

#region State Machine
//State machine is initialized in the in herited event.
//Define your states for this actor here.

truestate_create_state(STATES.INACTIVE, state_game_inactive, "INACTIVE");
truestate_create_state(STATES.GAME_SETUP, state_game_setup, "GAME SETUP");
truestate_create_state(STATES.PLAYER_ACTIVE, state_game_player_active, "PLAYER_ACTIVE");
truestate_create_state(STATES.AI_ACTIVE, state_game_ai_active, "AI_ACTIVE");
truestate_create_state(STATES.PAUSED, state_game_paused, "PAUSED");

//Set your default state. 
//This will be the state your object starts in, as well as the state that is defaulted
//to if you make a mistake and try switching to a state that doesn't exist.
truestate_set_default(STATES.INACTIVE);
#endregion

//Methods

function activateRoom(_roomX, _roomY)
{
	var _x = co_roomGen.levelGrid[# _roomX, _roomY][$"gridX1"];
	var _y = co_roomGen.levelGrid[# _roomX, _roomY][$"gridY1"];
	
	var _width = co_roomGen.levelGrid[# _roomX, _roomY][$"gridX2"] - _x;
	var _height = co_roomGen.levelGrid[# _roomX, _roomY][$"gridY2"] - _y;
	
	//Change grid coords to actual coords
	_x = from_grid(_x);
	_y = from_grid(_y);
	_width = from_grid(_width);
	_height = from_grid(_height);
	
	
	//Activate the enemy instances
	instance_activate_region(_x, _y, _width, _height, true);	
	
}

function deactivateRoom(_roomX, _roomY)
{
	var _x = co_roomGen.levelGrid[# _roomX, _roomY][$"gridX1"];
	var _y = co_roomGen.levelGrid[# _roomX, _roomY][$"gridY1"];
	
	var _width = co_roomGen.levelGrid[# _roomX, _roomY][$"gridX2"] - _x ; 
	var _height = co_roomGen.levelGrid[# _roomX, _roomY][$"gridY2"] - _y  ;
	
	//Change grid coords to actual coords
	_x = from_grid(_x);
	_y = from_grid(_y);
	_width = from_grid(_width) - (TILE_SIZE /4); // The minus is to keep the bounding box in the room
	_height = from_grid(_height)- (TILE_SIZE /4);
	
	
	//Activate the enemy instances
	instance_deactivate_region(_x, _y, _width, _height, true, true);
	
	//Draw the deactivate square for debugging
	//co_debugger.drawX1 = _x; 
	//co_debugger.drawY1 = _y;
	//co_debugger.drawX2 = _x + _width;
	//co_debugger.drawY2 = _y + _height;

}