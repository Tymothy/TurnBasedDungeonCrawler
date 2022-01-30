/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function array_rand_value(_array){
	/// @desc Returns a random value from a given array
	/// @arg Array	
	var _rand = irandom_range(0, array_length(_array) - 1);
	var _ret = _array[_rand];
	return _ret;
}