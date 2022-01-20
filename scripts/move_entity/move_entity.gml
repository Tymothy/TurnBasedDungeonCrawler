/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/

function move_entity(_targX, _targY, _twerpType = TwerpType.inout_cubic){
	/// @desc Move entity to a position nicely. Returns true when done
	/// @arg ....
	/// @arg ....
	static twerpTimer = 0;
	x = twerp(_twerpType, x, _targX, twerpTimer / global.moveTime);
	y = twerp(_twerpType, y, _targY, twerpTimer / global.moveTime);
	twerpTimer += d(1);
	
	if(x == _targX && y == _targY) {
		twerpTimer = 0;
		return true;	
	} 
	else {
		return false;	
	}
}