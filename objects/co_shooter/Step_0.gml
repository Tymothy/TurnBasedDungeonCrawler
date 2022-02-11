/// @description Calculate the touch
//if(
//var _ts = get_touch_state_on_change();
var _ct = get_current_touch();
var _ts = get_touch_state_on_change();
var _qt = false //quick testing below.  Should be false to disable messages

//Move to always be ontop of the player
x = ob_player.x;
y = ob_player.y;

if(_ct != -1) {
	var _tx = get_touch_x(_ct);
	var _ty = get_touch_y(_ct);
	//show_debug_message("Touch coords: " + coords_string(_tx, _ty));
	currentX = _tx;
	currentY = _ty;
}

switch (_ts) {
	case -1:
		//No state change.  Don't don anything
		break;
	case STATES.IDLE:
		if(_qt) show_debug_message("TOUCH_STATE Change: Idle");	
	break;
					
	case STATES.NEW_TOUCH:
		if(_qt) show_debug_message("TOUCH_STATE Change: New touch");
		startX = _tx;
		startY = _ty;
	break;
				
	case STATES.SAME_TOUCH:
		if(_qt) show_debug_message("TOUCH_STATE Change: Same touch");	
	break;
					
	case STATES.DIFFERENT_TOUCH:
		if(_qt) show_debug_message("TOUCH_STATE Change: Diff touch");	
	break;
					
	case STATES.DRAGGING:
		if(_qt) show_debug_message("TOUCH_STATE Change: Dragging");	
	break;
					
	case STATES.RELEASE:
		if(_qt) show_debug_message("TOUCH_STATE Change: Release");
		determineFire();
		
		
	
}