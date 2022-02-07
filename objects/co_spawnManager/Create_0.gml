/// @description Spawn all entities in the game room


done = false; //use to track completion

//Spawn Player on spawn tile
var _spawnPlayer = spawn_player(); //If player is spawned, return 1

//Iterate through all rooms and spawn enemies
for(var i = 0; i < ds_grid_width(co_roomGen.levelGrid); i++) {
	for(var j = 0; j < ds_grid_height(co_roomGen.levelGrid); j++) {
		var _spawnAI = spawn_ai(ob_enemy_slime, 3, i, j); //Spawn 3 enemy slimes in the room		

	}
}


done = true; //Spawning is done

