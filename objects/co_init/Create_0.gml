/// @description Setup at game start

//Used for YAL's room pack extension.  Required at game start
room_pack_blank_object = co_blank;
//randomize();

//Create global vars
global.pathMoveSpeed = 4; //Objecs will move 4 pixel per step on pathing

//Init scaling
instance_create_depth(x,y,0,co_display);
instance_create_depth(x, y, -1000, co_touchMaster);
instance_create_depth(x, y, -1000, co_gameManager);




room_goto(rm_game);