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

//Called only once at beginning of the room
function createAiTurnOrder()
{
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
