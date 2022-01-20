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
	mp_grid_path(self.attributes.collisionGrid, entityPath, x, y, attributes.targetObject.x, attributes.targetObject.y, true);
	//TODO: Track collision with other enemies to prevent them from overlapping
				
	//Enemies can only move one tile at a time, per turn
	var _xx = path_get_point_x(entityPath, 1);
	var _yy = path_get_point_y(entityPath, 1);
							
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

checkPath = function() {
	if(entity != false) {	
				//Target cell is occupied, unable to move there.
				//Since we cannot move to target cell, try to reroute to find a valid path
				
				var i = 0;
				do {
					//Cycle through 3 iterations of pathing to see if a proper path can be found
					mp_grid_add_cell(self.attributes.collisionGrid, gridTargX, gridTargY);
					tempEntityX[i] = gridTargX;
					tempEntityY[i] = gridTargY;
					calcPath();
					i++;
				}
				until (entity == false || i == 4);
				
				if(i == 4) {
					//Path not found, set targets to current position to exit infinite loop
					targX = x;
					targY = y;					
				}
				
				//Clean up to not leave ghost collision
				for(var i = 0; i < array_length(tempEntityX); i++) {
					mp_grid_clear_cell(self.attributes.collisionGrid, tempEntityX[i], tempEntityY[i]);
				}
				
			}
}
	
moveDirect = function() {
	calcPath();
	checkPath();
}

setupMove = function() {
	entityPath = path_add();			
	mp_clear_entity(); //Clears self from entity grid
			
	targX = -1;
	targY = -1;
	entity = noone;	
}