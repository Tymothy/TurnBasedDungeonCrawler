/// @description Move player up one room
	roomX = floor(ob_player.x / TILE_SIZE / ROOM_SIZE);
	roomY = floor(ob_player.y / TILE_SIZE / ROOM_SIZE);
	
	roomX = roomX;
	roomY = roomY - 1;
	
	ob_player.x = roomX * TILE_SIZE * ROOM_SIZE + (TILE_SIZE * ROOM_SIZE / 2);
	ob_player.y = roomY * TILE_SIZE * ROOM_SIZE + (TILE_SIZE * ROOM_SIZE / 2);