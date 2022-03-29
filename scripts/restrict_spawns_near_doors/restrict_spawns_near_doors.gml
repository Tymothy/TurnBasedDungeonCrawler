/*
function <NAME>(_var1, _var2, _var3...) {
/// @desc ...
/// @arg ....
/// @arg ....
//CODE
}
*/
function restrict_spawns_near_doors(){
	/// @desc restricts ai spawning near doors
	for(var i = 0; i < ds_grid_width(co_grid.tileGrid); i++) {
		for(var j = 0; j < ds_grid_height(co_grid.tileGrid); j++) {
			
			var _tile = check_grid(co_grid.tileGrid, i, j, "_door");
			if(_tile == true) {
				//Set all tiles around to unspawnable
				for(var a = -1; a <= 1; a++){
					for(var b = -1; b <= 1; b++){
						var _x = i + a;
						var _y = j + b;

						co_grid.tileGrid[# _x, _y][$"_aiSpawnable"] = false;
					}
				}
					
				
				//show_debug_message("Door at: " + coords_string(i, j));
			}
		}
	}
}