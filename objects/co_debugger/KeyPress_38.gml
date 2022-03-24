/// @description Move player up one room
	roomX = floor(ob_player.x / TILE_SIZE / ROOM_SIZE_WIDTH);
	roomY = floor(ob_player.y / TILE_SIZE / ROOM_SIZE_HEIGHT);
	
	roomX = roomX;
	roomY = roomY - 1;
	
	ob_player.x = roomX * TILE_SIZE * ROOM_SIZE_WIDTH + (TILE_SIZE * ROOM_SIZE_WIDTH / 2);
	ob_player.y = roomY * TILE_SIZE * ROOM_SIZE_HEIGHT + (TILE_SIZE * ROOM_SIZE_HEIGHT / 2);