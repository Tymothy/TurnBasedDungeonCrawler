/// @description Create Slime

// Inherit the parent event
event_inherited();

property.attackable = true;
property.moveSpeed = 1;
property.turnSpeed = 1;
property.name = "Slime";
property.collisionGrid = co_grid.mpGrid_collideOther;
property.targetObject = ob_player;
property.hp = 1;
property.attackRange = 1;
property.attackPower = 1;
property.attacks.direct = true;
property.attacks.slide = false;
property.hp = 1;

#region Methods

takeDamage = function (_damage) {
	truestate_switch(STATES.HURT);
	property.hp = property.hp - _damage;
	if(LOGGING) show_debug_message("Slime took " + string(_damage) + " damage.");
	if(LOGGING) show_debug_message("Slime has " + string(property.hp) + " health left.");
}

#endregion


truestate_create_state(STATES.WAIT, state_ai_wait);
truestate_create_state(STATES.ATTACK, state_ai_attack);
truestate_create_state(STATES.MOVE, state_ai_move);
truestate_create_state(STATES.HURT, state_ai_hurt);
sprite_index = sp_slime;