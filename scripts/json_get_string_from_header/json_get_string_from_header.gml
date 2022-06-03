/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc Given a header and string, pull out the associated json data
/// @arg string_header
/// @arg string_of_data
//CODE
}
*/
function json_get_string_from_header(_header, _string){
		var _headerPos = string_pos(_header, _string);
		//show_debug_message(string(_headerPos));
		var _startPos = string_pos_ext("{", _string, _headerPos);
		var _endPos = string_pos_ext("}", _string, _headerPos) +1; //+1 at end to get ending }
		var _length = _endPos - _startPos;
		var _strCopy = string_copy(_string, _startPos, _length);
		//show_debug_message(_strCopy);
		var _data = json_parse(_strCopy);
		//show_debug_message(_data);
		
		return _data;
}