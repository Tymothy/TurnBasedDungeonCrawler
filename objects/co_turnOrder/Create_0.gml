/// @description Setup
/*
TODO: Each type of ai will always be in a specific turn order.
A list needs to be with a list of all AI that exist in the room.

For example, given a room of two enemy types, all of the "faster" enemies will go first, with slower
enemies going next.  Since this all happens on the enemies turn, there's no real impact to the player
on which enemies go when, except possibly in order of enemy friendly fire (if implemented)
*/

//After each ai takes their turn, continue to next AI in the list
//After all ai have taken their turn, variable aiTurnComplete will equal true

aiTurnComplete = false; //When true, all ai have complete and game manager can continue
aiTurnNum = 0; //Tracks where ai are at in turn order

//Deactivate all ai objects as they will be activated as player enters each room
instance_deactivate_object(ob_par_ai);

//Called when player enters a new room
function createAiTurnOrder()
{
	var _roomX = to_room(to_grid(ob_player.x));
	var _roomY = to_room(to_grid(ob_player.y));
	
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
	
	//Create aiQueue if needed
		aiQueue = ds_priority_create();	
		aiCurrentTurnQueue = ds_priority_create();
		
	//Clear the aiQueue to ensure it's clean before starting
	ds_priority_clear(aiQueue);
	ds_priority_clear(aiCurrentTurnQueue);
	
	//Cycle through all ai in the room and add them to the turn order
	for (var i = 0; i <  instance_number(ob_par_ai); i++) {
		var _aiID = instance_find(ob_par_ai, i);
		var _aiSpeed = _aiID.attributes.turnSpeed;
		
		////Find if turn speed already exists, if so, add .01 until no match to avoid mismatches
		//var _prio = ds_priority_find_priority(aiQueue, _aiSpeed);
		//while(_prio != undefined) {
		//	_aiSpeed += .01;
		//	_prio = ds_priority_find_priority(aiQueue, _aiSpeed);
		//}
		if(LOGGING) show_debug_message("Adding " + string(_aiID.attributes.aiName) + "/" + string(_aiID) 
										+ " with value " + string(_aiSpeed) + " to the turn order.");
		ds_priority_add(aiQueue, _aiID, _aiSpeed);
	}
	if(LOGGING) show_debug_message("Created AI Turn successfully");
}

//Need a way to clean up list/delete after aiQueue is empty
function startAiTurn() {
	
	aiTurnNum = 0;
	aiTurnComplete = false;
	
	ds_priority_clear(aiCurrentTurnQueue); // Clear current queue, just in case
	ds_priority_copy(aiCurrentTurnQueue, aiQueue); 	//Copy turn order into a second list that can be removed from
	
	
}

function getNextAiTurn() {
	//Returns false if there are no ai left to go, otherwise returns instance id of ai to go
	if(ds_priority_empty(aiCurrentTurnQueue)) {
		aiTurnComplete = true;
		return false;
	}
	var _ret = ds_priority_delete_max(aiCurrentTurnQueue); //Get the value of the max, then delete it	
	return _ret;
}

function removeFromQueue(inst) {
	//Get Instance id of the object being removed from queue
	
		ds_priority_delete_value(aiQueue, inst);
		ds_priority_delete_value(aiCurrentTurnQueue, inst);
}