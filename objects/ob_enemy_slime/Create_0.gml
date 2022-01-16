/// @description Create Slime

// Inherit the parent event
event_inherited();

attributes =
{
	turnSpeed : 1, //Higher numbers will go first
	aiName : "Slime",
	collisionGrid : co_grid.mpGrid_collideOther,
	targetObject : ob_player,
	attackStyle : ATTACK.DIRECT,
	attackRange : 1,
	attackPower : 1,
	hp : 1,
}

#region Methods
takeDamage = function (_damage) {
	truestate_switch(STATES.HURT);
	attributes.hp = attributes.hp - _damage;
	if(LOGGING) show_debug_message("Slime took " + string(_damage) + " damage.");
	if(LOGGING) show_debug_message("Slime has " + string(attributes.hp) + " health left.");
}

#endregion


truestate_create_state(STATES.WAIT, state_ai_slime_wait);
truestate_create_state(STATES.ATTACK, state_ai_slime_attack);
truestate_create_state(STATES.MOVE, state_ai_slime_move);
truestate_create_state(STATES.FLEE, state_ai_slime_flee);
truestate_create_state(STATES.HURT, state_ai_slime_hurt);