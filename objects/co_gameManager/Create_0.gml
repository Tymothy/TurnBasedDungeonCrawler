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

//Game controlling values
hostilesInRoom = false; //Flag is checked every step and can be referenced by other objects

function refreshRoomValues() {
	currentRoomX = to_room_x(to_grid(ob_player.x));
	currentRoomY = to_room_y(to_grid(ob_player.y));
	currentFloor = global.game.currentFloor;
	currentRoomType = co_roomGen.levelGrid[# currentRoomX, currentRoomY][$"roomType"];
	leftGridX = co_roomGen.levelGrid[# currentRoomX, currentRoomY][$"gridX1"];
	topGridY = co_roomGen.levelGrid[# currentRoomX, currentRoomY][$"gridY1"];
	co_minimap.refreshMinimap();
	hostileCount = getHostileCount(); //Gets count of enemies in room
}

function runRoomConditions() {
		show_debug_message("Current Room: " + string(currentRoomType));
		show_debug_message("Boss Room Type: " + string(ROOMTYPE.BOSS));	
	switch(currentRoomType) {

		case ROOMTYPE.BOSS:
			show_debug_message("We are in a boss room, checking conditions");
			
			
			//If hostile count is less than 1, create a ladder down
			if(hostileCount < 1 && !instance_exists(ob_ladderDown)){
				show_debug_message("Creating a ladder down at grid: " + string(leftGridX + ROOM_SIZE_WIDTH / 2) + ", " + string(topGridY + ROOM_SIZE_HEIGHT / 2));
				instance_create_layer(from_grid(leftGridX + ROOM_SIZE_WIDTH / 2 ) - TILE_SIZE / 2, from_grid(topGridY + ROOM_SIZE_HEIGHT / 2) + TILE_SIZE / 2, "la_doors", ob_ladderDown);
				
			}
			break;
	}
	
	
}
//Methods
	
function resetRoom() {
	//Resets the entire game room, not just a floor cell.  Acts as if room is being entered for the first time
	room_restart();
}

function moveDownLevel() {
	//Run transition

	//TODO: Incorporate anything that needs saved on current floor
	global.game.currentFloor += 1;

	//Change values for the next room

	resetRoom();
	
}

#region Entity functions
function hurtHostiles() {
	for (var i = 0; i <  instance_number(ob_par_hostile); i++) {

			var _aiID = instance_find(ob_par_hostile, i);		
			var _inRoom = is_instance_in_current_room(_aiID);
			if(_inRoom == true) {
				_aiID.takeDamage(1);
			}
		}
		if(LOGGING) show_debug_message("Damaged all hostiles in room by 1");	
}
function getHostileCount () {
	//Returns number of hostiles
	//Could be expanded in the future to get specific counts
		//for (var i = 0; i <  instance_number(ob_par_hostile); i++) {
		//	var _aiID = instance_find(ob_par_hostile, i);
		//}
		//return i;
		var _count = 0;
		for (var i = 0; i <  instance_number(ob_par_ai); i++) {

		var _aiID = instance_find(ob_par_ai, i);		
		var _inRoom = is_instance_in_current_room(_aiID);
		if(_inRoom == true) {
			_count++;
		}
	}
	return _count;

}

function getListOfEntities() {
	return entityList;
}
	
function getCountOfEntities() {
	return array_length(entityList);
}
	
function addEntityToList(_inst) {
	show_debug_message("Adding instance: " + string(_inst) + " | " + string(object_get_name(_inst.object_index)));
	
	var _countOfEntities = co_gameManager.getCountOfEntities();
	var _entityList = co_gameManager.getListOfEntities();	
	var _entityStruct = {};
	//New entity struct for saving
	for (var i = 0; i < _countOfEntities; i++;) {
		//var _checkID = real(_entityList[i]);
		var _checkID = _entityList[i];
		if(_checkID == _inst) {
			show_debug_message("Trying to add instance that already exists.  Not adding to list.");
			return false;
		}		
	}
	//Entity does not exist in list.  Create it
		var _tempStruct = new saveEntity(_inst);
		_entityStruct.entities[i] = _tempStruct;
		if(_entityStruct.entities[i]){}  //This line does absolutely nothing in code.  However it prevents IDE from throwing a warning above.
		//tempStruct has what we want to put into entity struct	
	array_push(entityList, _inst);	
	return true;
}

function removeEntityFromList(_inst) {
	show_debug_message("Removing instance: " + string(_inst));
	
	_inst = string(_inst);
	for(var i = 0; i < array_length(entityList); i++) {
		//show_debug_message("Checking if " +string(_inst) + " matches " + string(entityList[i])); //Old line of code that allowed me to figure what checks were happening since profiler couldn't show me array values
		if(string(_inst) == string(entityList[i])) { //Convert both to strings as a tough bug here was because ids are stored as ref #, but you aren't able to refer to compare IDs then
			array_delete(entityList, i, 1);
			return true;
		}
	}
	show_debug_message("Tried to delete a instance from entity list that did not exist");
	return false;
}

function loadSavedEntities(_data) {
	//json_parse(_data);
	entityList = array_create(0);
	entityStruct = _data;
	show_debug_message("Loaded entities: " + string(_data));
}
#endregion	