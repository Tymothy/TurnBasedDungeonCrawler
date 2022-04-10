/// @description Move player down one room
	roomX = floor(ob_player.x / TILE_SIZE / ROOM_SIZE_WIDTH);
	roomY = floor(ob_player.y / TILE_SIZE / ROOM_SIZE_WIDTH);
	
	roomX = roomX;
	roomY = roomY + 1;
	
	ob_player.x = roomX * TILE_SIZE * ROOM_SIZE_WIDTH + (TILE_SIZE * ROOM_SIZE_WIDTH / 2);
	ob_player.y = roomY * TILE_SIZE * ROOM_SIZE_WIDTH + (TILE_SIZE * ROOM_SIZE_WIDTH / 2);
