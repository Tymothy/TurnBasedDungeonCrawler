/// @description Create parent entity

// Inherit the parent event
event_inherited();
mp_add_entity();

d_image_speed = 1; //Set entities to animate at standard speed
stateMachine = false;

property =
{
	attackable : false, //Whether or not entity is attackable
	turnSpeed : 0, //Higher numbers will go first
	name : "Default Name", //Name of the entity
	collisionGrid : co_grid.mpGrid_noCollision, //collision grid to use for colliding
	targetObject : noone, 
	chosenAttack : noone, //Basic attack sytle
	movePattern : MOVE.SEEK_DIRECT,
	
	attacks:
	{
		//Melee Attacks
		direct : false,	 //Determines whether or not entity can attack directly
		slide: false, //Determines if entity can slide attack
		
		//Range Attacks
	},
	meleeAttackRange : 1, //How far away basic attack can hit
	meleeAttackPower : 1, //How far away basic attack can hit
	hp : 1, 
}
	

takeDamage = function (_damage) {
	if(stateMachine == true) {
		truestate_switch(STATES.HURT);
	}
	
	property.hp = property.hp - _damage;
	if(LOGGING) show_debug_message(string(property.name) + " took " + string(_damage) + " damage.");
	if(LOGGING) show_debug_message(string(property.name) + " has " + string(property.hp) + " health left.");
}
