/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/

function move_entity(_targX, _targY){
	/// @desc Move entity to a position nicely. Returns true when done
	/// @arg ....
	/// @arg ....
	
	x = twerp(TwerpType.inout_cubic, x, _targX, twerpTimer / global.moveTime);
	y = twerp(TwerpType.inout_cubic, y, _targY, twerpTimer / global.moveTime);
	twerpTimer += d(1);
	
	if(x != _targX && y != _targY) return true;
	else return false;
}