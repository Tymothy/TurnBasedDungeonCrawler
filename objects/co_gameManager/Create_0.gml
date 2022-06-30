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
	rightGridX = co_roomGen.levelGrid[# currentRoomX, currentRoomY][$"gridX2"];
	topGridY = co_roomGen.levelGrid[# currentRoomX, currentRoomY][$"gridY1"];
	bottomGridY = co_roomGen.levelGrid[# currentRoomX, currentRoomY][$"gridY2"];
	co_minimap.refreshMinimap();
	hostileCount = getHostileCount(); //Gets count of enemies in room
}

function checkConditions() {
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
	refreshRoomValues();
}


function createListOfEntities() {
	//Creates a master list of entities on the floor.  Must be run before deactivating instances
	entityList = array_create(0);
	
	
	
	//var _countOfEntities = instance_number(ob_par_entity);
	//show_debug_message("Count of entities on floor: " + string(_countOfEntities));
	
	//for (var i = 0; i < instance_number(ob_par_entity); ++i;) {
	//	var _objID = instance_find(ob_par_entity, i);		
	//	array_push(entityList, _objID);
	//}

	//var _string = json_stringify(entityList);
	//show_debug_message("List of created entities: ");
	//show_debug_message(_string);
}

function getListOfEntities() {
	
	return entityList;
}

function addEntityToList(_inst) {
	show_debug_message("Adding instance: " + string(_inst) + " | " + string(object_get_name(_inst.object_index)));
	
	var _countOfEntities = co_gameManager.getCountOfEntities();
	var _entityList = co_gameManager.getListOfEntities();
	
	var _entityStruct = {};
	//New entity struct for saving
	for (var i = 0; i < _countOfEntities; i++;) {
		var _checkID = real(_entityList[i]);
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

function getCountOfEntities() {
	
	return array_length(entityList);
}
	
function removeEntityFromList(_inst) {
	show_debug_message("Removing instance: " + string(_inst));
	
	_inst = string(_inst);
	for(var i = 0; i < array_length(entityList); i++) {
		if(_inst == entityList[i]) {
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
	
function resetRoom() {
	
	room_restart();
	
}

function moveDownLevel() {
	//Run transition

	//TODO: Incorporate anything that needs saved on current floor
	global.game.currentFloor += 1;

	//Change values for the next room

	resetRoom();
	
}
