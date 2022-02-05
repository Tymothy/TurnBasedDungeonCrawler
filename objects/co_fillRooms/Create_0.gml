/// @description Populate the rooms

/*
Start at top left room, and go through the rooms

For each room:
	
	Create doors linking to other rooms
	Spawn enemies in room according to room type
*/

	for(var i = 0; i < ds_grid_width(co_roomGen.levelGrid); i++) {
		for(var j = 0; j < ds_grid_height(co_roomGen.levelGrid); j++) {
			var _roomType = co_roomGen.levelGrid[# i, j][$ "roomType"];
			
			//Find out if we are checking a valid room in the first place
			if(_roomType != ROOMTYPE.NONE) {
				//Room exists, create the doors
				
				//Get grid x and y of center of room to be able to work door placement
				var _x = i * ROOM_SIZE + floor(ROOM_SIZE / 2);
				var _y = j * ROOM_SIZE + floor(ROOM_SIZE / 2);
				var _offset = floor(ROOM_SIZE / 2);
				
				//Check each neighboring room to see if a room exists.  If it does, create a door
				//TODO: Future will need special doors to determine special rooms
				
				//Check above, then right, then down, then left
				var _roomUp = check_grid(co_roomGen.levelGrid, i, j - 1, "roomType");
				//var _roomUp = co_roomGen.levelGrid[# i, j][$ "roomType"];
				var _roomRight = check_grid(co_roomGen.levelGrid, i + 1, j, "roomType");
				var _roomDown = check_grid(co_roomGen.levelGrid, i, j + 1, "roomType");
				var _roomLeft = check_grid(co_roomGen.levelGrid, i - 1, j, "roomType");
				
				//Handle the doors
				if(_roomUp != ROOMTYPE.NONE && _roomUp != noone) {
					//Create the door
					var _inst = instance_create_layer(from_grid(_x), from_grid(_y - _offset), "la_doors", ob_door);
					co_grid.open_door(_x, _y - _offset);
					with (_inst) {
						//If we want to do anything with the door we just created, do it here.
							
					}
				}
				if(_roomRight != ROOMTYPE.NONE && _roomRight != noone) {
					//Create the door
					var _inst = instance_create_layer(from_grid(_x + _offset), from_grid(_y), "la_doors", ob_door);
					co_grid.open_door(_x + _offset, _y);
					with (_inst) {
						//If we want to do anything with the door we just created, do it here.
							
					}
				}				
				if(_roomDown != ROOMTYPE.NONE && _roomDown != noone) {
					//Create the door
					var _inst = instance_create_layer(from_grid(_x), from_grid(_y + _offset), "la_doors", ob_door);
					co_grid.open_door(_x, _y + _offset);
					with (_inst) {
						//If we want to do anything with the door we just created, do it here.
							
					}
				}
				if(_roomLeft != ROOMTYPE.NONE && _roomLeft != noone) {
					//Create the door
					var _inst = instance_create_layer(from_grid(_x - _offset), from_grid(_y), "la_doors", ob_door);
					co_grid.open_door(_x - _offset, _y);
					with (_inst) {
						//If we want to do anything with the door we just created, do it here.
							
					}
				}					
				
			}
		}
	}