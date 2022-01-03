/// @description Setup at game start

//Used for YAL's room pack extension.  Required at game start
room_pack_blank_object = co_blank;

//Init scaling
instance_create_depth(x,y,0,co_display);
instance_create_depth(x, y, -1000, co_touchMaster);