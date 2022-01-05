/// @desc Initialize State Machine and properties
event_inherited();

#region State Machine
//State machine is initialized in the in herited event.
//Define your states for this actor here.

truestate_create_state(STATES.INACTIVE, state_game_inactive, "INACTIVE");
truestate_create_state(STATES.SETUP, state_game_setup, "SETUP");
truestate_create_state(STATES.PLAYER_STARTING, state_game_player_starting, "PLAYER_STARTING");
truestate_create_state(STATES.PLAYER_ACTIVE, state_game_player_active, "PLAYER_ACTIVE");
truestate_create_state(STATES.PLAYER_ENDING, state_game_player_ending, "PLAYER_ENDING");
truestate_create_state(STATES.AI_STARTING, state_game_ai_starting, "AI_STARTING");
truestate_create_state(STATES.AI_ACTIVE, state_game_ai_active, "AI_ACTIVE");
truestate_create_state(STATES.AI_ENDING, state_game_ai_ending, "AI_ENDING");
truestate_create_state(STATES.TURN_END, state_game_turn_end, "TURN_END");
truestate_create_state(STATES.PAUSED, state_game_paused, "PAUSED");

//Set your default state. 
//This will be the state your object starts in, as well as the state that is defaulted
//to if you make a mistake and try switching to a state that doesn't exist.
truestate_set_default(STATES.INACTIVE);
#endregion