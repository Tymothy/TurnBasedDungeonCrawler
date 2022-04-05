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
property.meleeAttackRange = 1;
property.meleeAttackPower = 1;
property.attacks.direct = true;
property.attacks.slide = false;
property.hp = 1;

#region Methods



#endregion

stateMachine = true;
truestate_create_state(STATES.WAIT, state_ai_wait);
truestate_create_state(STATES.ATTACK, state_ai_attack);
truestate_create_state(STATES.MOVE, state_ai_move);
truestate_create_state(STATES.HURT, state_ai_hurt);
sprite_index = sp_slime;