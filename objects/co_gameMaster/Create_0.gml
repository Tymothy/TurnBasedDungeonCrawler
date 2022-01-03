/// @description Manage the game room
//Run the packed room generation to generate the game room
instance_create_layer(x, y, "la_controllers",co_packedRoomManager);

//All rooms are created, create the collision grid
instance_create_layer(x,y, "la_controllers", co_grid);

//Spawn entities in game room, including player
instance_create_layer(x,y, "la_controllers", co_spawnManager);