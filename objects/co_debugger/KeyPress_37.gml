/// @description Move player left one room
	roomX = floor(ob_player.x / TILE_SIZE / ROOM_SIZE);
	roomY = floor(ob_player.y / TILE_SIZE / ROOM_SIZE);
	
	roomX = roomX - 1;
	roomY = roomY;
	
	ob_player.x = roomX * TILE_SIZE * ROOM_SIZE + (TILE_SIZE * ROOM_SIZE / 2);
	ob_player.y = roomY * TILE_SIZE * ROOM_SIZE + (TILE_SIZE * ROOM_SIZE / 2);