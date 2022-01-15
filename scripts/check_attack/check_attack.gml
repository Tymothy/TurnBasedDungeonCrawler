/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function check_valid_attacks(_obj = self){
	/// @desc Returns what attacks are valid from current position, given an object.  If no object is given, return self
	/// @arg object(optional)

	validAttacks = {
		direct : true,
		lunge : true,
	}
	return validAttacks;

}