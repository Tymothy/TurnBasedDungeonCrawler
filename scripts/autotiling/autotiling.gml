/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function autotile_bitmask(_t, _b, _l, _r, _tl = 0, _tr = 0, _bl = 0, _br = 0){
/// @desc Returns the bitmask for a set of tiles
/// @arg top tile
/// @arg bottom tile
/// @arg left tile
/// @arg right tile
/// @arg top left
/// @arg top right
/// @arg bottom left
/// @arg bottom right

//The last 4 arguments, the corners, are optional

//If edges aren't set, corners must be false
if !(_t && _l) _tl = false;
if !(_t && _r) _tr = false;
if !(_b && _l) _bl = false;
if !(_b && _r) _br = false;

//Computer bitmask
var _bitmaskTile =
(_t ? 1:0) +
(_tr ? 2:0) +
(_r ? 4:0) +
(_br ? 8:0) +
(_b ? 16:0) +
(_bl ? 32:0) +
(_l ? 64:0) +
(_tl ? 128:0)

return _bitmaskTile;
}

function autotile_check_tile(_tile, _coreTile) {
/// @desc Returns 0 or 1 if the tile is matching
/// @arg tile to determine bitmask for
/// @arg tile to see if it's the same or not as the tile

	if(_tile == _coreTile) {
		return 1;	
	}
	else {
		return 0;	
	}
	
}