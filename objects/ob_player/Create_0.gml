/// @description Init
event_inherited();
//Put into a JSON file to allow easy changing and reference
sprite = sp_player_core;
moveSpeed = 1; //Can move X tiles per turn



//Variables that aren't configured
xGridCoord = to_grid(x);
yGridCoord = to_grid(y);



sprite_index = sprite;

#region State Machine
//State machine is initialized in the in herited event.
//Define your states for this actor here.

truestate_create_state(STATES.IDLE, state_player_idle, "Idle");
truestate_create_state(STATES.WALK, state_player_walk, "Walk");
truestate_create_state(STATES.ATTACK, state_player_attack, "Attack");
truestate_create_state(STATES.HURT, state_player_hurt, "Hurt");
truestate_create_state(STATES.ITEM_GET, state_player_item_get, "Item_Get");

//Set your default state. 
//This will be the state your object starts in, as well as the state that is defaulted
//to if you make a mistake and try switching to a state that doesn't exist.
truestate_set_default(STATES.IDLE);
#endregion

has_sword=false;