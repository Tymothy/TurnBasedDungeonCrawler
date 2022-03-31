/// @description Create parent entity

// Inherit the parent event
event_inherited();
mp_add_entity();

d_image_speed = 1; //Set entities to animate at standard speed

property =
{
	attackable : false, //Whether or not entity is attackable
	turnSpeed : 0, //Higher numbers will go first
	name : "Default Name", //Name of the entity
	collisionGrid : co_grid.mpGrid_noCollision, //collision grid to use for colliding
	targetObject : noone, 
	attackStyle : ATTACK.DIRECT, //Basic attack sytle
	attacks:
	{
		direct : false,	 //Determines whether or not entity can attack directly
		slide: false, //Determines if entity can slide attack
	},
	attackRange : 1, //How far away basic attack can hit
	attackPower : 1, //How far away basic attack can hit
	hp : 1, 
}
	

takeDamage = function (_damage) {
	show_debug_message("ERROR: DEFAULT HURT METHOD MESSAGE.");
}