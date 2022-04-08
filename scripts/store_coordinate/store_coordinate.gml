/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function store_coordinate(_array, _x, _y){
	var _len = array_length(_array);
	_array[_len][0] = _x;
	_array[_len][1] = _y;
	return _array;
}