/// @description Create parent entity

// Inherit the parent event
event_inherited();
mp_add_entity();

d_image_speed = 1; //Set entities to animate at standard speed
stateMachine = false;
chosenAttack = noone; 
targetObject = noone;
alarm[0] = LOGIC_TICK;

property =
{
	attackable : false, //Whether or not entity is attackable
	turnSpeed : 0, //Higher numbers will go first
	name : "Default Name", //Name of the entity
	collisionGrid : co_grid.mpGrid_noCollision, //collision grid to use for colliding

	movePattern : MOVE.SEEK_DIRECT,
	//Create a move setup like attacks
	attacks:
	{
		//Melee Attacks
		meleeDirect : false,	 //Determines whether or not entity can attack directly
		meleeSlide: false, //Determines if entity can slide attack
		
		//Range Attacks
		rangeLine : false, //Determines if the entity can attack in a straight line
		rangeDiag : false, //Determines if the entity can attack in a diagonal line
		
	},
	meleeAttackRange : 0, //How far away melee attack can hit
	meleeAttackPower : 0, //How strong melee attack is
	
	rangeAttackRange : 0, //How far away range attack can hit
	rangeAttackPower : 0, //How strong range attack is
	
	hp : 1, 
}
	

takeDamage = function (_damage) {
	if(stateMachine == true) {
		truestate_switch(STATES.HURT);
	}
	
	property.hp = property.hp - _damage;
	temp = _damage;
	with(instance_create_layer(x, y, "la_gui_2", ob_hurtVisual)){
		value = other.temp;
	}
	if(LOGGING) show_debug_message(string(property.name) + " took " + string(_damage) + " damage.");
	if(LOGGING) show_debug_message(string(property.name) + " has " + string(property.hp) + " health left.");
}
