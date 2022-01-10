/// @description Setup
/*
TODO: Each type of ai will always be in a specific turn order.
A list needs to be with a list of all AI that exist in the room.

For example, given a room of two enemy types, all of the "faster" enemies will go first, with slower
enemies going next.  Since this all happens on the enemies turn, there's no real impact to the player
on which enemies go when, except possibly in order of enemy friendly fire (if implemented)
*/

//After each ai takes their turn, they are removed from the priority list.
//When priority list is empty, end the ai turn
function getTurnOrder()
{
	//Create aiQueue if needed
	if !ds_exists(aiQueue, ds_type_priority) {
		aiQueue = ds_priority_create();	
	}
	
	//Clear the aiQueue to ensure it's clean before starting
	ds_priority_clear(aiQueue);
	
	//Cycle through all ai in the room and add them to the turn order
	for (var i = 0; i <  instance_number(ob_par_ai); i++) {
		var _aiID = instance_find(ob_par_ai, i);
		var _aiSpeed = _aiID.attributes.turnSpeed;
		
		//Find if turn speed already exists, if so, add .01 until no match to avoid mismatches
		while(ds_priority_find_priority(aiQueue, _aiSpeed) != undefined) {
			_aiSpeed += .01;	
		}
		if(LOGGING) show_debug_message("Adding " + string(_aiID.attributes.aiName) + "/" + string(_aiID) 
										+ " with value " + string(_aiSpeed) + " to the turn order.");
		ds_priority_add(aiQueue, _aiID, _aiSpeed);
	}
	
	
}

//Need a way to clean up list/delete after aiQueue is empty