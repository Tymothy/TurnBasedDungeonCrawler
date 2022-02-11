/// @description Create
/*
Watches for the player to be dragging, then will fire based on the drag
*/
minDist = MIN_DIST_TO_FIRE;

startX = -1; //The x where the touch started
startY = -1; //The y where the touch started
currentX = -1; // The X where the touch is currently at
currentY = -1; //The Y where the touch is currently at

vel = 10; //Velocity to shoot the projectile at

determineFire = function() {
	minDist = MIN_DIST_TO_FIRE; //Get the value just in case it has changed
	var _dist = point_distance(startX, startY, currentX, currentY);
	var _dir = point_direction(currentX, currentY, startX, startY);  //Current is first so projectile goes the correct way
	show_debug_message("Determining fire");
	show_debug_message("Min dist to fire is: " + string(minDist));
	show_debug_message("Current dist on release is: " + string(_dist))
	
	if(_dist > minDist) {
		fire(_dir, vel);	
	}
	
	resetCoords();
}

fire = function(_dir, _vel) {
	show_debug_message("FIRE!");
	var _inst = instance_create_layer(x, y, "la_projectiles", ob_projectile);
	with(_inst) {
		vel = _vel;
		dir = _dir;
	}
}

resetCoords = function() {
	startX = -1;
	startY = -1;
	currentX = -1;
	currentY = -1;
}