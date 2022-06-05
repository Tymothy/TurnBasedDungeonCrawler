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
		
		//Need to find out how to get the ending to the bracket, if another one is found
		/*
		iterate over each character to see if another { is found
		if found, add 1 to a variable
		every time a } is found, -1 to variable
		if a } is found when variable is at 0, that is the one we want to use for endPos
		*/
		var _bracketCounter = 1;
		for(var i = _startPos + 1; i < string_length(_string); i++) { //i is startPos + 1 to start checking the next char after the open bracket
			var _char = string_char_at(_string, i);
			
			switch(_char) {
				case "}": 
					_bracketCounter--;
					break;
					
				case "{":
					_bracketCounter++;
					break;
			}
			
			if(_bracketCounter == 0) {
				//We found the end of the json file that we want.
				var _endPos = _startPos + i + 1;
				break; //End the for loop early
			}
			
		}
		
		//var _endPos = string_pos_ext("}", _string, _headerPos) +1; //+1 at end to get ending }
		
		var _length = _endPos - _startPos;
		var _strCopy = string_copy(_string, _startPos, _length);
		//show_debug_message(_strCopy);
		var _data = json_parse(_strCopy);
		//show_debug_message(_data);
		
		return _data;
}