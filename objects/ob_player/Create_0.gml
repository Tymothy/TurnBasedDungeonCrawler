/// @description Init
event_inherited();
//Put into a JSON file to allow easy changing and reference
sprite = sp_player_core;

attributes =
{
	moveSpeed : 1, //Can move X tiles per turn
	name : "Player",
	collisionGrid : co_grid.mpGrid_collidePlayer,
	attackStyle : ATTACK.DIRECT,
	attackRange : 1,
	attackPower : 1,
	hp : 3,
}

//Variables that aren't configured
xGridCoord = to_grid(x);
yGridCoord = to_grid(y);

//Init variables for state machine
turnActive = false;
endTurn = false;

#region Methods
takeDamage = function (_damage) {
	truestate_switch(STATES.HURT);
	attributes.hp = attributes.hp - _damage;
	if(LOGGING) show_debug_message("Player took " + string(_damage) + " damage.");
	if(LOGGING) show_debug_message("Player has " + string(attributes.hp) + " health left.");
}

#endregion


sprite_index = sprite;

#region State Machine
//State machine is initialized in the in herited event.
//Define your states for this actor here.
truestate_create_state(STATES.WAIT, state_player_wait, "Wait");
truestate_create_state(STATES.IDLE, state_player_idle, "Idle");
truestate_create_state(STATES.MOVE, state_player_move, "Move");
truestate_create_state(STATES.ATTACK, state_player_attack, "Attack");
truestate_create_state(STATES.HURT, state_player_hurt, "Hurt");
truestate_create_state(STATES.ITEM_GET, state_player_item_get, "Item_Get");

//Set your default state. 
//This will be the state your object starts in, as well as the state that is defaulted
//to if you make a mistake and try switching to a state that doesn't exist.
truestate_set_default(STATES.WAIT);
#endregion

has_sword=false;