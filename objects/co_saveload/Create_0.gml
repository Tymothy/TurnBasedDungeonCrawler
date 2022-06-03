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
	var _saveArray = array_create(0);	
	for (var i = 0; i < _countOfEntities; i++;) {
		var _objID = _entityList[i];
	
		var _entityInfo = {
			obj : object_get_name(_objID.object_index),
			//id : _objID.id,
			x : to_grid(_objID.x),
			y : to_grid(_objID.y),
			image_index : _objID.image_index,
		}
		
		array_push(_saveArray, _entityInfo);	
		}
	
	//Turn data into a JSON string and save it via a buffer
	_string += json_append("entities", _saveArray);
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
		
		var _loadData = json_parse(_string);
		
		show_debug_message("String: " + _string);
		show_debug_message("loadData: "+ string(_loadData));
	}
}