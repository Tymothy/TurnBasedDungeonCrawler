/// @description Insert description here
// You can write your code in this editor

loadGameSave = false; //If set to true, we want to load the save

save = function () {
	show_debug_message("Saving...");
	

	var _string = "{"; //Start the json file
	//Save the global variables
	var _globalGameStruct = global.game;	
	_string += json_append("global", _globalGameStruct);
	
	
	//Save the entities
	var _countOfEntities = co_gameManager.getCountOfEntities();
	var _entityList = co_gameManager.getListOfEntities();
	
	var _entityStruct = {};
	//New entity struct for saving
	for (var i = 0; i < _countOfEntities; i++;) {
		var _instID = real(_entityList[i]);
		var _tempStruct = new saveEntity(_instID);
		_entityStruct.entities[i] = _tempStruct;

		//tempStruct has what we want to put into entity struct

	}	
		show_debug_message(string(_entityStruct));	
	//Get rid of the save array
	
	//var _saveArray = array_create(0);	
	//for (var i = 0; i < _countOfEntities; i++;) {
	//	var _objID = _entityList[i];
	
	//	var _entityInfo = {
	//		obj : object_get_name(_objID.object_index),
	//		//id : _objID.id,
	//		x : to_grid(_objID.x),
	//		y : to_grid(_objID.y),
	//		image_index : _objID.image_index,
	//	}
		
	//	array_push(_saveArray, _entityInfo);	
	//	}
	
	////Turn data into a JSON string and save it via a buffer
	_string += json_append("entities", _entityStruct);
	_string += "}"; //End the JSON File
	
	//Save via a buffer
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, "gamesave.sav");
	buffer_delete(_buffer);
	
	show_debug_message("Done saving!");
}
	
loadGame = function() {
	if(file_exists("gamesave.sav")) {
		var _buffer = buffer_load("gamesave.sav");
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
		
		//Load the global data
		var _header = "global";
		var _data = json_get_string_from_header(_header, _string);
		
		//show_debug_message("Seed before: " + string(global.game.seed));
		global.game = _data;
		//show_debug_message("Seed after: " + string(global.game.seed));
		
		//Load the entity data
		_header = "entities";
		_data = json_get_string_from_header(_header, _string);
		show_debug_message("Entities Loaded: " + string(_data));
		
		co_gameManager.loadSavedEntities(_data);
		
		//show_debug_message("String: " + _string);
		//show_debug_message("loadData: "+ string(_loadData));
	}
}