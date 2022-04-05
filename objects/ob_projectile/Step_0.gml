/// @description Move the projectile
event_inherited();
x += lengthdir_x(vel, dir);
y += lengthdir_y(vel, dir);

image_angle = dir;
if(place_meeting(x, y, targetObject)) {
	//Checks to see if projectile is touching an entity
	//Performance could be improved by only checking when on a tile that is on the entity grid
	instance_destroy();
	
}
