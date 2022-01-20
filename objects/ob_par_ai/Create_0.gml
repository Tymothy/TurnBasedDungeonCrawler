/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

aiActive = false; //Controlled by co_gameManager on when this object can go

attributes =
{
	turnSpeed : 0, //Higher numbers will go first
	aiName : "Default Name",
}

calcPath = function() {
	mp_grid_path(self.attributes.collisionGrid, aiPath, x, y, attributes.targetObject.x, attributes.targetObject.y, true);
	//TODO: Track collision with other enemies to prevent them from overlapping
				
	//Enemies can only move one tile at a time, per turn
	var _xx = path_get_point_x(aiPath, 1);
	var _yy = path_get_point_y(aiPath, 1);
							
	//Calc grid point to move to
	targX = to_grid(_xx);
	targY = to_grid(_yy);
	gridTargX = targX;
	gridTargY = targY;
	//Get the room coords back.  This is need to ensure x and y are
	//On the actual grid coords, and not slightly off
	targX = from_grid(targX);
	targY = from_grid(targY);
				
	//Check entity grid, if filled, add to collision grid and then repath.
	//After repathing, clean up the adds
	entity = check_entity(gridTargX, gridTargY);
}
