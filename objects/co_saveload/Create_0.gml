/// @description Insert description here
// You can write your code in this editor

save = function () {
	show_debug_message("Saving...");
	
	var _saveData = array_create(0);


	//Save the entities
	var _countOfEntities = co_gameManager.getCountOfEntities();
	var _entityList = co_gameManager.getListOfEntities();
	
	for (var i = 0; i < _countOfEntities; i++;) {
		var _objID = _entityList[i];
	
		var _entityInfo = {
			obj : object_get_name(_objID.object_index),
			id : _objID.id,
			x : _objID.x,
			y : _objID.y,
			image_index : _objID.image_index,
		}
		array_push(_saveData, _entityInfo);	
			
			
		}
	
	//Turn data into a JSON string and save it via a buffer
	var _string = json_stringify(_saveData);
	var _buffer = buffer_create(string_byte_length(_string) +1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, "savedgame.save");
	buffer_delete(_buffer);
	
	show_debug_message("Done saving!");
}
	