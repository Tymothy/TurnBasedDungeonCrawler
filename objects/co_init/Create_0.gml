/// @description Setup at game start
randomize();

init(); //Creates the global vars from the configuration script
//Used for YAL's room pack extension.  Required at game start
room_pack_blank_object = co_blank;
//randomize();


//Setup functions
game_set_speed(GAME_SPEED, gamespeed_fps);

global.moveTime = GAME_SPEED * MOVE_LENGTH;


//Variables we want to save
global.game = {
	currentFloor : 1,
	seed : random_get_seed(),
}

//Create objects that control referenced values
instance_create_depth(x, y, -1000, co_tilesetMapping);

//Init scaling
instance_create_depth(x, y, -1000, co_touchMaster);
instance_create_depth(x, y, -1000, co_gameManager);
instance_create_depth(x, y, -1000, co_music);
	//Create the save controller
instance_create_depth(x, y, -1000, co_saveLoad);

room_goto(rm_game);