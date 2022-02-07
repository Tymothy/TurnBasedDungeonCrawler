/// @description Spawn all entities in the game room


done = false; //use to track completion

//Spawn Player on spawn tile
var _spawnPlayer = spawn_player(); //If player is spawned, return 1

//Iterate through all rooms and spawn enemies
for(var i = 0; i < ds_grid_width(co_roomGen.levelGrid); i++) {
	for(var j = 0; j < ds_grid_height(co_roomGen.levelGrid); j++) {
		switch(co_roomGen.levelGrid[# i, j][$"difficulty"]) {
			case DIFFICULTY.EASY:
				var _spawnAI = spawn_ai(ob_enemy_slime, 3, i, j); //Spawn 3 enemy slimes in the room	
				break;
				
			case DIFFICULTY.MEDIUM:
				var _spawnAI = spawn_ai(ob_enemy_slime, 5, i, j); //Spawn 5 enemy slimes in the room	
				break;

			case DIFFICULTY.HARD:
				var _spawnAI = spawn_ai(ob_enemy_slime, 7, i, j); //Spawn 7 enemy slimes in the room	
				break;
			
			default:
			
				break;
			
		}
			

	}
}


done = true; //Spawning is done

