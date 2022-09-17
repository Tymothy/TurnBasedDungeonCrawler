/// @description Create Player
if(live_call()) return live_result;
event_inherited();
//Put into a JSON file to allow easy changing and reference
sprite = sp_player_hero1;


property.attackable = true;
property.moveSpeed = 1;
property.name = "Player";
property.collisionGrid = co_grid.mpGrid_collidePlayer;
targetObject = noone;
property.meleeAttackRange = 1;
property.meleeAttackPower = 1;
property.attacks.meleeDirect = true;
property.attacks.meleeSlide = true;
property.hp = 5;
property.energy = 2;

//Variables that aren't configured
xGridCoord = to_grid(x);
yGridCoord = to_grid(y);

//Init variables for state machine
turnActive = false;
endTurn = false;

#region Methods
movingRoomsFunc = function() {
	//Changed back to false from gameManager
	movingRooms = true;	
	lastRoomGridX = to_grid(x);
	lastRoomGridY = to_grid(y);
	
	if(LOGGING) show_debug_message("Player is leaving room at: " + coords_string(to_room_x(lastRoomGridX), to_room_y(lastRoomGridY)));
	//Activate instances in the room we are going to prior to actually moving there
	//co_gameManager.activateRoom(to_room_x(to_grid(targX)), to_room_y(to_grid(targY)));
}

#endregion


sprite_index = sprite;

#region State Machine
//State machine is initialized in the in herited event.
//Define your states for this actor here.
stateMachine = true;
truestate_create_state(STATES.WAIT, state_player_wait, "Wait");
truestate_create_state(STATES.IDLE, state_player_idle, "Idle");
truestate_create_state(STATES.MOVE, state_player_move, "Move");
truestate_create_state(STATES.ATTACK, state_player_attack, "Attack");
truestate_create_state(STATES.HURT, state_player_hurt, "Hurt");
truestate_create_state(STATES.ITEM_GET, state_player_item_get, "Item_Get");
truestate_create_state(STATES.END, state_player_end, "End Turn");
truestate_create_state(STATES.DEAD, state_player_dead, "Dead");
//Set your default state. 
//This will be the state your object starts in, as well as the state that is defaulted
//to if you make a mistake and try switching to a state that doesn't exist.
truestate_set_default(STATES.WAIT);
#endregion

has_sword = false;
movingRooms = false;
lastRoomGridX = xGridCoord;
lastRoomGridY = xGridCoord;

activateSpell = function (_spell) {
	switch(_spell) {
		case SPELL.MOVE:
			ob_player.modifier.moveSpell.active = true;
			ob_player.modifier.moveSpell.speed += 1;
		break;
			
	}	
	
}


deactivateSpell = function(_spell) {
	switch(_spell) {
		case SPELL.MOVE:
			if(ob_player.modifier.moveSpell.active == true) {
				ob_player.modifier.moveSpell.active = false;
				ob_player.modifier.moveSpell.speed -= 1;
				if(instance_exists(button_moveSpell)) {
					if(button_moveSpell.active == true) {
						button_moveSpell.interact();	
					}
				}
			}
		break;
			
	}
	
}

canCastSpell = function(_spell) {
	//checks if a certain spell can currently be cast
	var _cost = 0;
	var _enabled = false;
	
	switch(_spell) {
		case SPELL.MOVE:
			_cost = ob_player.modifier.moveSpell.cost;
			_enabled = ob_player.modifier.moveSpell.enabled;
		break;
	}
	if(_cost <= ob_player.property.energy && _enabled == true){
		return true;			
	}
	return false;
}