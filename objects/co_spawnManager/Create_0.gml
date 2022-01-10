/// @description Spawn all entities in the game room


done = false; //use to track completion

//Spawn Player on spawn tile
var _spawnPlayer = spawn_player(); //If player is spawned, return 1


var _spawnAI = spawn_ai_test(ob_enemy_slime, 3); //Spawn 3 enemy slimes in the room

done = true; //Spawning is done

