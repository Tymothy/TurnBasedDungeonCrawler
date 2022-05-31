/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function json_append(_heading, _data){
	var _string = "\"";
	_string += string(_heading);
	_string += "\": ";
	_string += json_stringify(_data);
	_string += ", ";
	return _string;
}