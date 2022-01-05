/// @description truestate_get_name 
/// @param {real} StateEnum
function truestate_get_name(argument0) {

	/// Returns the string name of the passed state.

	var _name = truestate_names[? argument0];
	return _name == undefined ? "Undefined" : _name;


}
