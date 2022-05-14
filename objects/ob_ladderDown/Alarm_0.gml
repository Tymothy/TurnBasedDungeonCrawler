/// @description Check to see if player is on tile
//ob_ladderdown Alarm_0

// Inherit the parent event
event_inherited();
if(place_meeting(x, y, ob_player)) {
	show_debug_message("Player is on ladder, move player to next level.");
	co_gameManager.moveDownLevel();
}

