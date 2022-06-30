/// @description Spawn all entities in the game room


done = false; //use to track completion

//Check if we need to load from a entity list or create a new set
if(co_saveLoad.loadGameSave == true) {
	//We want to spawn entities from the save file only.
	
		 //var _inst = 0;
		 tempList = {};
		 tempList = co_gameManager.getListOfEntities();
		// var _countOfEntities = co_gameManager.getCountOfEntities();
		 //var _tempStruct = co_gameManager.entityStruct;

		for(var i = 0; i < array_length(co_gameManager.entityStruct.entities); i++) {
			//var _inst = co_gameManager.entityList[i];
			//spawn_entity(asset_get_index(co_gameManager.entityStruct[i].obj), co_gameManager.entityStruct[i].x, co_gameManager.entityStruct[i].y);
			spawn_entity(asset_get_index(co_gameManager.entityStruct.entities[i].obj), co_gameManager.entityStruct.entities[i].x, co_gameManager.entityStruct.entities[i].y);
			if(LOGGING) show_debug_message("Loaded " + string(asset_get_index(co_gameManager.entityStruct.entities[i].obj)));
		}
	if(LOGGING) show_debug_message("Done Loading.  Entities loaded: " + string(i));

	//while(array_length(_entityData) > 0) {
	//	var _loadEntity = array_pop(_entityData);
	//	spawn_entity(asset_get_index(_loadEntity.obj), _loadEntity.x, _loadEntity.y);
		
	//}

	
	//spawn_entity //Spawn the ai
	
} else {

	//Spawn Player on spawn tile
	var _spawnPlayer = spawn_player(); //If player is spawned, return 1

	//Iterate through all rooms and spawn enemies
	for(var i = 0; i < ds_grid_width(co_roomGen.levelGrid); i++) {
		for(var j = 0; j < ds_grid_height(co_roomGen.levelGrid); j++) {
			//Spawn in the approriate rooms
			switch(co_roomGen.levelGrid[# i, j][$"difficulty"]) {
				case DIFFICULTY.EASY:
					var _spawnAI = spawn_ai(ob_bonySoldier, 2, i, j); //Spawn 3 enemy slimes in the room	
					var _spawnAI = spawn_ai(ob_exhumedCleric, 1, i, j); //Spawn 5 enemy slimes in the room	
					break;
				
				case DIFFICULTY.MEDIUM:
					var _spawnAI = spawn_ai(ob_bonySoldier, 4, i, j); //Spawn 5 enemy slimes in the room
					var _spawnAI = spawn_ai(ob_exhumedCleric, 2, i, j); //Spawn 5 enemy slimes in the room	
					break;

				case DIFFICULTY.HARD:
					var _spawnAI = spawn_ai(ob_bonySoldier, 4, i, j); //Spawn 7 enemy slimes in the room	
					var _spawnAI = spawn_ai(ob_exhumedCleric, 3, i, j); //Spawn 5 enemy slimes in the room	
					break;
			
				default:
			
					break;
			
			}
			

		}
	}
}
done = true; //Spawning is done

