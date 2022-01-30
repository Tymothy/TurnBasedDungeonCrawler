/// @description Move the camera

//Find room player is in, then set camera to that room
//TODO: This doesn't need to run every frame.  Just whenever player moves room to save resources
if(instance_exists(ob_player)){
	roomX = floor(ob_player.x / TILE_SIZE / ROOM_SIZE);
	roomY = floor(ob_player.y / TILE_SIZE / ROOM_SIZE);
	
	targX = roomX * TILE_SIZE * ROOM_SIZE;
	targY = roomY * TILE_SIZE * ROOM_SIZE;
}

camera_set_view_pos(camID, targX - xOffset, targY - yOffset);