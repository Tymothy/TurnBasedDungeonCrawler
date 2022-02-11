/// @description Create
/*
Watches for the player to be dragging, then will fire based on the drag
*/
minDist = MIN_DIST_TO_FIRE;

startX = -1; //The x where the touch started
startY = -1; //The y where the touch started
currentX = -1; // The X where the touch is currently at
currentY = -1; //The Y where the touch is currently at
determineFire = function() {
	minDist = MIN_DIST_TO_FIRE; //Get the value just in case it has changed
	var _dist = point_distance(startX, startY, currentX, currentY) 
	show_debug_message("Determining fire");
	show_debug_message("Min dist to fire is: " + string(minDist));
	show_debug_message("Current dist on release is: " + string(_dist))
	
	if(_dist > minDist) {
		fire();	
	}
	
	
}

fire = function() {
	show_debug_message("FIRE!");
}